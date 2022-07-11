//
//  File.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import Foundation

public class Logger {
    
    enum Level {
        case info
        case warning
        case error
        
        var prefix: String {
            switch self {
            case .info:
                return "ℹ️"
            case .warning:
                return "⚠️"
            case .error:
                return "❌"
            }
        }
    }
    
    private static var dateFormatter: DateFormatter = {
        let obj = DateFormatter()
        obj.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return obj
    }()
    
    // MARK: - private
    
    private static func log(_ items: Any..., separator: String = " ", terminator: String = "\n", level: Level, file: String, method: String, line: Int) {
        let now = dateFormatter.string(from: Date())
        let fileName = (file as NSString).lastPathComponent
        let logPrefix = "<\(now)> \(level.prefix) [\(fileName) \(line): \(method)]"
        
        // TODO: @whaley 若要支持日志上报，这里需要考虑 `items` 中数据的解析
        print(logPrefix, terminator: " ")
        print(items, separator: separator, terminator: terminator)
    }
    
    // MARK: - public
    
    public static func info(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line) {
        log(items, separator: separator, terminator: terminator, level: .info, file: file, method: method, line: line)
    }
    
    public static func warning(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line) {
        log(items, separator: separator, terminator: terminator, level: .warning, file: file, method: method, line: line)
    }
    
    public static func error(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line) {
        log(items, separator: separator, terminator: terminator, level: .error, file: file, method: method, line: line)
    }
    
}
