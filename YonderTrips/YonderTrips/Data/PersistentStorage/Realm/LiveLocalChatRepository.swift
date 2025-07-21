//
//  LiveLocalChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation
import RealmSwift

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
    
    func fetchChatList(roomId: String, lastDate: Date?) -> [ChatResponse] {
        
        if let list = fetchChatObject(roomId: roomId, lastDate: lastDate) {
            
            return Array(list)
                .map{ $0.toEntity() }
            
        } else {
            return []
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
