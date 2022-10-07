//
//  CellPackageModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/6.
//

import Foundation
import UIKit

struct CellPackageModel {
    var name: String
    var age: Int
    var introduction: String
    
    var itemSize: CGSize = .zero
    
    init(name: String, age: Int, introduction: String) {
        self.name = name
        self.age = age
        self.introduction = introduction
        
        self.itemSize = calcItemSize()
    }
    
    private func calcItemSize() -> CGSize {
        let itemWidth = (UIScreen.main.bounds.width - 15.0 * 2 - 10.0) / 2.0
        let nameHeight = name.boundingRect(with: CGSize(width: itemWidth - 15.0 * 2, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 18.0)], context: nil).height
        let ageHeight = "\(age)".boundingRect(with: CGSize(width: itemWidth - 15.0 * 2, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 14.0)], context: nil).height
        let introductionHeight = introduction.boundingRect(with: CGSize(width: itemWidth - 15.0 * 2, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 12.0)], context: nil).height
        let itemHeight = nameHeight + ageHeight + introductionHeight + 15.0 * 2 + 10.0 * 2 + 10.0
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
