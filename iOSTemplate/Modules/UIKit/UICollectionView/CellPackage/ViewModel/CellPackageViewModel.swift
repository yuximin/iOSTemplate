//
//  CellPackageViewModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/6.
//

import Foundation

class CellPackageViewModel {
    let models: [CellPackageModel]
    
    init() {
        self.models = [
            CellPackageModel(name: "Jack", age: 18, introduction: "上面这个模式写的多了渐渐的会发现一些弊端: 复用 Cell 需要特定的 Model 才行, 勉强搞了对应 Model(可能还会给这个 Model 添加新的属性) 想要在 setModel: 中添加新的业务时, 总会担心影响旧的逻辑"),
            CellPackageModel(name: "Jack", age: 18, introduction: "像这里的 Model"),
            CellPackageModel(name: "Jack", age: 18, introduction: "我琢磨着如何解决这些问题. 从 Cell 的角度来看"),
            CellPackageModel(name: "Jack", age: 18, introduction: "当通过上述方案增加动态性后, 随着数据内容的改变很有可能会使 size 也发生改变. 而在实际的应用场景中, 我们为了避免重复计算 size, 一般会缓存每个 Item 的 size, 因此需要提供一种能够刷新缓存的机制, 标识出哪个 Item 需要刷新 size, 由于修改属性的动作 Item 是有感知的(可以重写属性的 set 方法), 所以就让 Item 自己来标识")
        ]
    }
}
