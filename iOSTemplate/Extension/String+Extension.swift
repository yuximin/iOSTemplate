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

// MARK: - color
extension String {
    public var color: UIColor { UIColor(hexString: self) }
}

extension UIColor {
    
    /// - Parameters:
    ///   - hexString: hexadecimal string (examples: EDE7F6, 0xEDE7F6, #EDE7F6, #0ff, 0xF0F, ..).
    ///   - alpha: 不透明度 (default is 1).
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
            return
        }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
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
