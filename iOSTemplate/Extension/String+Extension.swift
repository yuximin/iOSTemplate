//
//  String+Extension.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/1.
//

import Foundation
import UIKit

// MARK: - font
extension String {
    public var font: UIFont {
        font(weight: .regular)
    }
    
    public func font(weight: UIFont.Weight) -> UIFont {
        let size = Float(self) ?? 10
        return .systemFont(ofSize: CGFloat(size), weight: weight)
    }
}

// MARK: - 正则替换
extension String {
    public func regexReplacing(pattern: String, withTemplate template: String) -> String {
        var result = self
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            result = regex.stringByReplacingMatches(in: result, range: NSMakeRange(0, result.count), withTemplate: template)
        } catch {
            Logger.info("String regexReplacing error: \(error.localizedDescription)")
        }
        return result
    }
}
