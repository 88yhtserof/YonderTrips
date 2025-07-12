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
        
        let userInfoObjects = room.participants.map {
            UserInfoObject(
                userId: $0.userId,
                nick: $0.nick,
                profileImage: $0.profileImage,
                introduction: $0.introduction
            )
        }
        let realmParticipants = List<UserInfoObject>()
        realmParticipants.append(objectsIn: userInfoObjects)
        
        let roomObject = ChatRoomObject(
            roomId: room.roomId,
            title: title,
            participants: realmParticipants
        )
        
        try! realm.write {
            realm.add(roomObject, update: .modified)
        }
    }
    
    func fetchChatList(roomId: String, lastDate: Date?) throws -> [ChatResponse] {
        
        if let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: roomId) {
            
            var query = room.chatList
                .sorted(byKeyPath: "createdAt", ascending: true)
            
            if let lastDate {
                query = query.filter("createdAt < %@", lastDate)
            }
            
            return Array(query.suffix(10))
                .map{ $0.toEntity() }
        }
        return []
    }
    
    func addChat(_ chat: ChatResponse) {
        
        let sender = chat.sender
        let userInfoObject = UserInfoObject(userId: sender.userId, nick: sender.nick, profileImage: sender.profileImage, introduction: sender.introduction)
        
        let chatObject = ChatObject(
            chatId: chat.chatId,
            roomId: chat.roomId,
            content: chat.content,
            createdAt: YTDateFormatter.date(from: chat.createdAt, format: .iso8601UTC) ?? Date(),
            updatedAt: YTDateFormatter.date(from: chat.updatedAt, format: .iso8601UTC) ?? Date(),
            sender: userInfoObject,
            files: chat.files
        )
        
        guard let room = realm.object(ofType: ChatRoomObject.self, forPrimaryKey: chat.roomId) else {
            return
        }
        
        chatObject.room = room
        
        try! realm.write {
            realm.add(chatObject)
            
            room.lastMessage = chat.content
            room.lastUpdatedAt = YTDateFormatter.date(from: chat.createdAt, format: .iso8601UTC) ?? Date()
        }
    }
    
    func observeMessages(completion: @escaping ([ChatResponse]) -> Void) -> NotificationToken {
        let results = realm.objects(ChatObject.self).sorted(byKeyPath: "createdAt", ascending: true)
        
        return results.observe { changes in
            switch changes {
            case .initial(let list):
                completion(Array(list).map{ $0.toEntity() })
            case .update(let list, _, _, _):
                completion(Array(list).map{ $0.toEntity() })
            case .error(let error):
                print("Realm notification error: \(error)")
                completion([])
            }
        }
    }
}

