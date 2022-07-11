//
//  UserInfoModel.swift
//  iOSTemplate
//
//  Created by whaley on 2022/7/10.
//

import Foundation

struct UserInfoModel: Codable {
    let list: [UserInfoItemModel]
}

struct UserInfoItemModel: Codable {
    let name: String
    let age: Int
    let sex: Int
    let isVip: Bool
    
    enum CodingKeys: String, CodingKey {
      case name
      case age
      case sex
      case isVip = "is_vip"
    }
    
    var sexValue: UserSex {
        guard let value = UserSex(rawValue: self.sex) else {
            return .unknown
        }
        
        return value
    }
}

enum UserSex: Int {
    case unknown = 0
    case male = 1
    case female = 2
}
