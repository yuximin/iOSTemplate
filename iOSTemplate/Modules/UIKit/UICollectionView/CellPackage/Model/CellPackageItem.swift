//
//  CellPackageItem.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/6.
//

import Foundation

class CellPackageItem {
    var model: CellPackageModel
    
    init(model: CellPackageModel) {
        self.model = model
    }
}

// MARK: - CellPackageCellDataSource
extension CellPackageItem: CellPackageCellDataSource {
    var nameText: String {
        model.name
    }
    
    var ageNumber: Int {
        model.age
    }
    
    var introductionText: String {
        model.introduction
    }
}
