//
//  LanguageContext.swift
//  iOSTemplate
//
//  Created by apple on 2024/8/5.
//

import UIKit

enum AppLanguage: Int, CaseIterable {
    case zh
    case en
    case ar
    
    var isRTL: Bool {
        switch self {
        case .ar:
            return true
        default:
            return false
        }
    }
    
    var appleLanguage: String {
        switch self {
        case .zh:
            return "zh-Hans"
        case .en:
            return "en"
        case .ar:
            return "ar"
        }
    }
    
    var semanticContentAttribute: UISemanticContentAttribute {
        self.isRTL ? .forceRightToLeft : .forceLeftToRight
    }
}

class LanguageContext {
    
    static var appLanguage: AppLanguage {
        get {
            getAppLanguage()
        }
        set {
            updateAppLanguage(newValue, needExit: true)
        }
    }
    
    static func applyFirstAppLanguage() {
        
        let hadApplyAppLanguage = (UserDefaults.standard.value(forKey: "AppLanguage.hadFirstApply") as? Bool) ?? false
        
        if hadApplyAppLanguage { return }
        
        UserDefaults.standard.setValue(true, forKey: "AppLanguage.hadFirstApply")
        UserDefaults.standard.synchronize()
        
        let appLanguages = Locale.preferredLanguages.compactMap { language -> AppLanguage? in
            guard let appLanguage = AppLanguage.allCases.first(where: { language.hasPrefix($0.appleLanguage) }) else {
                return nil
            }
            
            return appLanguage
        }
        
        let appLanguage = appLanguages.first ?? .zh
        updateAppLanguage(appLanguage)
    }
    
    private static func getAppLanguage() -> AppLanguage {
        guard let appLanguageVaule = UserDefaults.standard.value(forKey: "AppLanguage.value") as? Int else {
            return .zh
        }
        
        return AppLanguage(rawValue: appLanguageVaule) ?? .zh
    }
    
    private static func updateAppLanguage(_ lan: AppLanguage, needExit: Bool = false) {
        UserDefaults.standard.setValue(lan.rawValue, forKey: "AppLanguage.value")
        UserDefaults.standard.set([lan.appleLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        updateSemanticContentAttribute(appLanguage: lan)
        
        if needExit {
            exit(0)
        }
    }
    
    private static func updateSemanticContentAttribute(appLanguage: AppLanguage) {
        let semanticContentAttribute = appLanguage.semanticContentAttribute
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        UIButton.appearance().semanticContentAttribute = semanticContentAttribute
        UITextView.appearance().semanticContentAttribute = semanticContentAttribute
        UITextField.appearance().semanticContentAttribute = semanticContentAttribute
        UISearchBar.appearance().semanticContentAttribute = semanticContentAttribute
        UIScrollView.appearance().semanticContentAttribute = semanticContentAttribute
    }
}

extension UIView {
    
    static var isRTL: Bool {
        UIView.userInterfaceLayoutDirection(for: UIView.appearance().semanticContentAttribute) == .rightToLeft
    }
}


