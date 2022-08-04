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
