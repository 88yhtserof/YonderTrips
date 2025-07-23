//
//  LiveLocalChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation
import RealmSwift

enum PaginationDirection {
    case before
    case after
}

final class LiveLocalChatRepository: LocalChatRepository {
    
    private let realm = try! Realm()
    private let pageSize: Int
    
    init(pageSize: Int = 10) {
        self.pageSize = pageSize
        
        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
            print("📁 Realm 파일 위치: \(fileURL.path)")
        }
    }
    
    func addChatRoom(_ room: ChatRoomResponse) {
        
        let title = room.participants
            .map { $0.nick }
            .joined(separator: ", ")
        
        var userInfoObjectList: [UserInfoObject] = []
        
        for participant in room.participants {
            
            if let userInfoObject = realm.object(ofType: UserInfoObject.self, forPrimaryKey: participant.userId) {
                userInfoObjectList.append(userInfoObject)
                
            } else {
                let userInfoObject = UserInfoObject(
                    userId: participant.userId,
                    nick: participant.nick,
                    profileImage: participant.profileImage,
                    introduction: participant.introduction
                )
                userInfoObjectList.append(userInfoObject)
            }
        }
        
        let realmParticipants = List<UserInfoObject>()
        realmParticipants.append(objectsIn: userInfoObjectList)
        
        
        let existingRoom = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: room.roomId)
        
        if existingRoom == nil {
            let roomObject = ChatRoomObject(
                roomId: room.roomId,
                title: title,
                participants: realmParticipants
            )
            
            try! realm.write {
                realm.add(roomObject)
            }
        }
    }
    
    func containsChat(chatId: String) -> Bool {
        return realm.object(ofType: ChatObject.self, forPrimaryKey: chatId) != nil
    }
    
    func fetchChatListWithCursor(
        roomId: String,
        cursor: Date? = nil,
        direction: PaginationDirection = .before,
        limit: Int? = nil
    ) -> ChatPaginationResult {
        
        switch direction {
        case .before:
            return fetchChatsBefore(roomId: roomId, cursor: cursor, limit: limit)
        case .after:
            return fetchChatsAfter(roomId: roomId, cursor: cursor, limit: limit)
        }
    }
    
    func addChat(_ chat: ChatResponse) {
        
        if containsChat(chatId: chat.chatId) { return }
        
        guard let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: chat.roomId),
              let userInfoObject = realm.object(ofType: UserInfoObject.self, forPrimaryKey: chat.sender.userId) else {
            return
        }
        
        let chatObject = ChatObject(
            chatId: chat.chatId,
            roomId: chat.roomId,
            content: chat.content,
            createdAt: YTDateFormatter.date(from: chat.createdAt, format: .iso8601UTC) ?? Date(),
            updatedAt: YTDateFormatter.date(from: chat.updatedAt, format: .iso8601UTC) ?? Date(),
            sender: userInfoObject,
            files: chat.files
        )
        
        chatObject.room = room
        
        try! realm.write {
            realm.add(chatObject)
            
            room.lastMessage = chat.content
            room.lastUpdatedAt = YTDateFormatter.date(from: chat.createdAt, format: .iso8601UTC) ?? Date()
        }
    }
    
    func observeMessages(
        roomId: String,
        lastDate: Date?,
        completion: @escaping ([ChatResponse]) -> Void
    ) -> NotificationToken? {
        
        guard let results = fetchChatObject(roomId: roomId, lastDate: lastDate) else {
            return nil
        }
        
        return results.observe { changes in
            switch changes {
            case .initial(let response):
                YonderTripsLogger.shared.debug("Ininitial Realm notification")
                let list = Array(response)
                    .map{ $0.toEntity() }
                completion(list)
                
            case .update(let response, _, let insertions, _):
                YonderTripsLogger.shared.debug("Update Realm notification")
                
                if insertions.isEmpty { return }
                let list = insertions.map{ response[$0].toEntity() }
                completion(list)
                
            case .error(let error):
                YonderTripsLogger.shared.debug("Realm notification error: \(error)")
                completion([])
            }
        }
    }
}

private extension LiveLocalChatRepository {
    
    func fetchChatObject(roomId: String, lastDate: Date?) ->  Results<ChatObject>? {
        
        if let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: roomId) {
            
            var query = room.chatList
                .sorted(byKeyPath: "createdAt", ascending: true)
            
            if let lastDate {
                query = query.filter("createdAt < %@", lastDate)
            }
            
            return query
        }
        return nil
    }
}

// MARK: - Pagination Result Model
struct ChatPaginationResult {
    let chats: [ChatResponse]
    let hasMore: Bool
    let nextCursor: Date?
}

extension LiveLocalChatRepository {
    
    func fetchChatsAfter(
        roomId: String,
        cursor: Date? = nil,
        limit: Int? = nil
    ) -> ChatPaginationResult {
        
        guard let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: roomId) else {
            return ChatPaginationResult(chats: [], hasMore: false, nextCursor: nil)
        }
        
        let pageLimit = limit ?? pageSize
        
        var query = room.chatList.sorted(byKeyPath: "createdAt", ascending: true)
        
        if let cursor {
            query = query.filter("createdAt > %@", cursor)
        }
        
        let results = Array(query.prefix(pageLimit + 1))
        
        let hasMore = results.count > pageLimit
        let chats = hasMore ? Array(results.prefix(pageLimit)) : results
        
        let nextCursor = chats.last?.createdAt
        
        return ChatPaginationResult(
            chats: chats.map { $0.toEntity() },
            hasMore: hasMore,
            nextCursor: nextCursor
        )
    }
    
    func fetchChatsBefore(
        roomId: String,
        cursor: Date? = nil,
        limit: Int? = nil
    ) -> ChatPaginationResult {
        
        guard let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: roomId) else {
            return ChatPaginationResult(chats: [], hasMore: false, nextCursor: nil)
        }
        
        let pageLimit = limit ?? pageSize
        
        var query = room.chatList.sorted(byKeyPath: "createdAt", ascending: false)
        
        if let cursor = cursor {
            query = query.filter("createdAt < %@", cursor)
        }
        
        let results = Array(query.prefix(pageLimit + 1))
        
        let hasMore = results.count > pageLimit
        let chats = hasMore ? Array(results.prefix(pageLimit)) : results
        
        let sortedChats = chats.sorted { $0.createdAt < $1.createdAt }
        let nextCursor = sortedChats.first?.createdAt
        
        return ChatPaginationResult(
            chats: sortedChats.map { $0.toEntity() },
            hasMore: hasMore,
            nextCursor: nextCursor
        )
    }
    
    func fetchChatsAround(
        roomId: String,
        cursor: Date,
        beforeLimit: Int? = nil,
        afterLimit: Int? = nil
    ) -> (before: ChatPaginationResult, after: ChatPaginationResult) {
        
        let beforeResult = fetchChatsBefore(
            roomId: roomId,
            cursor: cursor,
            limit: beforeLimit
        )
        
        let afterResult = fetchChatsAfter(
            roomId: roomId,
            cursor: cursor,
            limit: afterLimit
        )
        
        return (before: beforeResult, after: afterResult)
    }
    
    func fetchLatestChats(
        roomId: String,
        limit: Int? = nil
    ) -> ChatPaginationResult {
        
        return fetchChatsBefore(roomId: roomId, cursor: nil, limit: limit)
    }
    
    func observeMessagesAfter(
        roomId: String,
        cursor: Date,
        completion: @escaping (ChatPaginationResult) -> Void
    ) -> NotificationToken? {
        
        guard let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: roomId) else {
            return nil
        }
        
        let query = room.chatList
            .filter("createdAt > %@", cursor)
            .sorted(byKeyPath: "createdAt", ascending: true)
        
        return query.observe { changes in
            switch changes {
            case .initial(let results):
                let chats = Array(results).map { $0.toEntity() }
                guard let last = chats.last else {
                    YonderTripsLogger.shared.debug("Could not find last chat")
                    return
                }
                let result = ChatPaginationResult(
                    chats: chats,
                    hasMore: false,
                    nextCursor: YTDateFormatter.date(from: last.createdAt, format: .iso8601UTC)
                )
                completion(result)
                
            case .update(let results, _, let insertions, _):
                if !insertions.isEmpty {
                    let newChats = insertions.map { results[$0].toEntity() }
                    guard let last = newChats.last else {
                        YonderTripsLogger.shared.debug("Could not find last chat")
                        return
                    }
                    let result = ChatPaginationResult(
                        chats: newChats,
                        hasMore: false,
                        nextCursor: YTDateFormatter.date(from: last.createdAt, format: .iso8601UTC)
                    )
                    completion(result)
                }
                
            case .error(let error):
                YonderTripsLogger.shared.debug("Realm observation error: \(error)")
                completion(ChatPaginationResult(chats: [], hasMore: false, nextCursor: nil))
            }
        }
    }
}
