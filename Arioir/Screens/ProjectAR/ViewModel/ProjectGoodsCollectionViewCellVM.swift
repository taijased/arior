//
//  ProjectGoodsCollectionViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import Foundation



protocol ProjectGoodsCollectionViewCellVMType: class {
    var label: String { get }
    var iconName: String { get }
}

class ProjectGoodsCollectionViewCellVM: ProjectGoodsCollectionViewCellVMType {

    private var goods: Goods
    
       
    var label: String {
        return goods.name ?? ""
    }

    var iconName: String {
        return goods.picture ?? ""
    }
    
    
    init(goods: Goods) {
        self.goods = goods
    }
}
