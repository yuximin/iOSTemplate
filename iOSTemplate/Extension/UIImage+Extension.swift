//
//  UIImage+Extension.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/4.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 修改图片方向
    public func orientationImage(_ orientation: UIImage.Orientation) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        return UIImage(cgImage: cgImage, scale: scale, orientation: orientation)
    }
}
