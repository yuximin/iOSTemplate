//
//  LayoutSubviewsDemoView.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/13.
//

import UIKit

class LayoutSubviewsDemoView: UIView {
    
    var name: String = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("LayoutSubviewsDemoView -- layoutSubviews: \(name)")
    }

}
