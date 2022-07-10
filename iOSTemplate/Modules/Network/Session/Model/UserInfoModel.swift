//
//  UserInfoModel.swift
//  iOSTemplate
//
//  Created by whaley on 2022/7/10.
//

import Foundation

struct UserInfoModel: Codable {
    let list: [UserInfoItemModel]
    
    enum CodingKeys: String, CodingKey {
      case list
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserInfoModel.CodingKeys.self)
        self.list = try container.decode([UserInfoItemModel].self, forKey: .list)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserInfoModel.CodingKeys.self)
        try container.encode(self.list, forKey: .list)
    }
}

struct UserInfoItemModel: Codable {
    let name: String
    let age: Int
    let sex: UserSex
    let isVip: Bool
    
    enum CodingKeys: String, CodingKey {
      case name
      case age
      case sex
      case isVip = "is_vip"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserInfoItemModel.CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        let sex = try container.decodeIfPresent(Int.self, forKey: .sex) ?? 0
        if let userSex = UserSex(rawValue: sex) {
            self.sex = userSex
        } else {
            self.sex = .unknown
        }
        self.isVip = try container.decodeIfPresent(Bool.self, forKey: .isVip) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserInfoItemModel.CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        let sex = self.sex.rawValue
        try container.encode(sex, forKey: .sex)
        try container.encode(self.isVip, forKey: .isVip)
    }
}

enum UserSex: Int {
    case unknown = 0
    case male = 1
    case female = 2
}
