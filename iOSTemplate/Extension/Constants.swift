//
//  Constants.swift
//  iOSTemplate
//
//  Created by apple on 2024/1/3.
//

import UIKit

/// 状态栏高度
public let kStatusBarHeight: CGFloat = {
    var statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    let safeAreaInsetsTop = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    if #available(iOS 16.0, *) {
        // Xcode13或者之后的版本编译的包，在iPhone14Pro及Max取到的状态栏高度是44，实际是59，需要做调整
        let isNeedAdjust = (statusBarHeight == 44.0)
        if safeAreaInsetsTop == 59.0 && isNeedAdjust {
            statusBarHeight = 59.0
        }
        return statusBarHeight
    } else {
        return max(statusBarHeight, safeAreaInsetsTop)
    }
}()

/// 导航栏高度
public let kNavigationBarHeight: CGFloat = 44

/// 状态栏+导航栏 高度
public let kTopBarHeight: CGFloat = {
    return kStatusBarHeight + kNavigationBarHeight
}()

public let kSafeAreaBottomHeight: CGFloat = {
    return isIphoneXSeries ? 34 : 0
}()

/// 屏幕宽度
public let kScreenWidth: CGFloat = {
    return UIScreen.main.bounds.size.width
}()

/// 屏幕高度
public let kScreenHeight: CGFloat = {
    return UIScreen.main.bounds.size.height
}()

/// 屏幕比例(相对于iPhone6、7、8)
public let kScreenScale: CGFloat = {
    return kScreenWidth / 375.0
}()

/// 屏幕宽比例(相对于iPhone6、7、8)
public let kAdaptWidth: CGFloat = {
    return kScreenWidth / 375.0
}()

/// 屏幕高比例(相对于iPhone6、7、8)
public let kAdaptHeight: CGFloat = {
    return kScreenHeight / 667.0
}()

/// 状态栏frame
public let kStatusBarFrame: CGRect = {
    return UIApplication.shared.statusBarFrame
}()

/// 屏幕的安全区域大小
public let kSafeArea: UIEdgeInsets = {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
    } else {
        return UIEdgeInsets.zero
    }
}()

/// 是否为iPhone X系列
public let isIphoneXSeries: Bool = {
    if #available(iOS 11.0, *) {
        return (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0.0) > CGFloat(0.0)
    } else {
        return false
    }
}()

public let isPad: Bool = {
    func getVersionCode() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        return versionCode
    }
    let isPad: Bool = getVersionCode().contains("iPad")
    return isPad
}()

public let kShortVersionString: String = {
    let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)?.components(separatedBy: "-").first
    return version ?? "1.0.0"
}()

public let kBundleVersionString: String = {
    return (Bundle.main.infoDictionary?[String(kCFBundleVersionKey)] as? String) ?? "1"
}()

public let kAppStoreUrl = "itms-apps://itunes.apple.com/app/id1569526879"

public extension CGFloat {
    // 屏幕宽适配
    var scaleW: CGFloat {
        return ceil(self * kAdaptWidth)
    }
    // 屏幕高适配
    var scaleH: CGFloat {
        return ceil(self * kAdaptHeight)
    }
}

public extension Int {
    // 屏幕宽适配
    var scaleW: CGFloat {
        return ceil(CGFloat(self) * kAdaptWidth)
    }
    // 屏幕高适配
    var scaleH: CGFloat {
        return ceil(CGFloat(self) * kAdaptHeight)
    }
}

public extension Double {
    // 屏幕宽适配
    var scaleW: CGFloat {
        return ceil(CGFloat(self) * kAdaptWidth)
    }
    // 屏幕高适配
    var scaleH: CGFloat {
        return ceil(CGFloat(self) * kAdaptHeight)
    }
    // 保留几位小数
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
