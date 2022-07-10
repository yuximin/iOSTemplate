//
//  File.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import Foundation

public class Logger {
    
    public static func info(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        print("ℹ️", items, separator: separator, terminator: terminator)
    }
    
    public static func warn(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        print("⚠️", items, separator: separator, terminator: terminator)
    }
    
    public static func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        print("❌", items, separator: separator, terminator: terminator)
    }
}
