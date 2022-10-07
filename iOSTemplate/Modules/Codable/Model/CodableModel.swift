//
//  RoomModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/7.
//

import Foundation

struct CodableModel: Codable {
    let room: [RoomModel]
    let user: [UserModel]
}

struct RoomModel: Codable {
    var id: Int
    var name: String
    var heat: Int
    var count: Int
    var bulletin: String
    var country: String
}

struct UserModel: Codable {
    var id: Int
    var nick: String
    var avatar: String
    var followed: Int
    var vipLevel: Int
    
    // CodingKeys中枚举的key才会参与Codable
    // 未自定义时，系统会自动包含所有存储属性的CodingKeys
    enum CodingKeys : String,CodingKey {
        case id, nick, avatar, followed
        case vipLevel = "vip_level" // key特殊处理
    }
    
    // 计算属性不参与Codable
    var hasFollowed: Bool {
        return followed == 1
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserModel.CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.avatar = try container.decode(String.self, forKey: .avatar)
        self.followed = try container.decodeIfPresent(Int.self, forKey: .followed) ?? 0 // key不存在时设置默认值
        self.vipLevel = try container.decode(Int.self, forKey: .vipLevel)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserModel.CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.nick, forKey: .nick)
        try container.encode(self.avatar, forKey: .avatar)
        try container.encode(self.followed, forKey: .followed)
        try container.encode(self.vipLevel, forKey: .vipLevel)
    }
}
