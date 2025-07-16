//
//  UserInfoObject.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation
import RealmSwift

class UserInfoObject: Object {
    @Persisted(primaryKey: true) var userId: String
    @Persisted var nick: String
    @Persisted var profileImage: String
    @Persisted var introduction: String
    
    convenience init(userId: String, nick: String, profileImage: String, introduction: String) {
        self.init()
        self.userId = userId
        self.nick = nick
        self.profileImage = profileImage
        self.introduction = introduction
    }
}

extension UserInfoObject {
    
    func toEntity() -> UserInfo {
        return UserInfo(
            userId: userId,
            nick: nick,
            profileImage: profileImage,
            introduction: introduction
        )
    }
}
