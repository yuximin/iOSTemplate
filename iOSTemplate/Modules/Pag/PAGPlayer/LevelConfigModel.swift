//
//  LevelConfigModel.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/27.
//

import Foundation

struct LevelConfigModel {
    let url: String
    let levelRange: String
    
    static var demoItems: [LevelConfigModel] {
        return [
            .init(url: "https://client.karawangroup.com/level/1-9.pag", levelRange: "1-9"),
            .init(url: "https://client.karawangroup.com/level/10-19.pag", levelRange: "10-19"),
            .init(url: "https://client.karawangroup.com/level/20-29.pag", levelRange: "20-29"),
            .init(url: "https://client.karawangroup.com/level/30-39.pag", levelRange: "30-39"),
            .init(url: "https://client.karawangroup.com/level/40-49.pag", levelRange: "40-49"),
            .init(url: "https://client.karawangroup.com/level/50-59.pag", levelRange: "50-59"),
            .init(url: "https://client.karawangroup.com/level/60-69.pag", levelRange: "60-69"),
            .init(url: "https://client.karawangroup.com/level/70-79.pag", levelRange: "70-79"),
            .init(url: "https://client.karawangroup.com/level/80-89.pag", levelRange: "80-89"),
            .init(url: "https://client.karawangroup.com/level/90-99.pag", levelRange: "90-99"),
            .init(url: "https://client.karawangroup.com/level/100.pag", levelRange: "100-109"),
            .init(url: "https://client.karawangroup.com/level/110-119.pag", levelRange: "110-119"),
            .init(url: "https://client.karawangroup.com/level/120-129.pag", levelRange: "120-129"),
            .init(url: "https://client.karawangroup.com/level/130-139.pag", levelRange: "130-139"),
            .init(url: "https://client.karawangroup.com/level/140-149.pag", levelRange: "140-149"),
            .init(url: "https://client.karawangroup.com/level/150.pag", levelRange: "150")
        ]
    }
    
    func inRange(_ level: Int) -> Bool {
        let ranges = levelRange.split(separator: "-")
        if ranges.count == 1,
           let value = Int(ranges[0]),
           value == level {
            return true
        }
        
        guard ranges.count == 2 else {
            return false
        }
        
        guard let lRange = Int(ranges[0]), let rRange = Int(ranges[1]) else {
            return false
        }
        
        guard level >= lRange, level <= rRange else {
            return false
        }
        
        return true
    }
}
