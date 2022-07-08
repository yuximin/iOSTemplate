//
//  File.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import Foundation

public class Logger {
    
    public static func info(_ message: String) {
        print("ℹ️ \(message)")
    }
    
    public static func warn(_ message: String) {
        print("⚠️ \(message)")
    }
    
    public static func error(_ message: String) {
        print("❌ \(message)")
    }
}
