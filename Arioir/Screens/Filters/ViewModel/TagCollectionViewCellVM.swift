//
//  TagCollectionViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 17.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import Foundation



protocol TagCollectionViewCellVMType: class {
    var label: String { get }
    var status: Bool { get }
}

class TagCollectionViewCellVM: TagCollectionViewCellVMType {

    private var tag: TagModel
    
       
    var label: String {
        return tag.label
    }

    var status: Bool {
        return tag.status
    }
    
    
    init(tag: TagModel) {
        self.tag = tag
    }
}
