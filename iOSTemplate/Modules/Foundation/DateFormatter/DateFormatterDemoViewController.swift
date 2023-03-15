//
//  DateFormatterDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/3/15.
//

import UIKit

class DateFormatterDemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "DateFormatter"
        view.backgroundColor = .white
        
        print(Locale.current)
        print(UserDefaults.standard.value(forKey: "AppleLanguages"))
        print(Date().timeIntervalSince1970)
        
        let date = Date(timeIntervalSince1970: 1678860178)
        dateFormatterStringForDate(date, localeIdentifier: "en")
        dateFormatterStringForDate(date, localeIdentifier: "zh")
        dateFormatterStringForDate(date, localeIdentifier: "ja")
        dateFormatterStringForDate(date, localeIdentifier: "tr")
        dateFormatterStringForDate(date, localeIdentifier: "哈哈哈")
    }
    
    private func dateFormatterStringForDate(_ date: Date, localeIdentifier: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE,dd/MM,HH:mm:ss"
        let dateLocal = Locale(identifier: localeIdentifier)
        dateFormatter.locale = dateLocal
        print(localeIdentifier, dateLocal, dateFormatter.string(from: date))
    }

}
