//
//  FiltersTableViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol FiltersTableViewCellVMType: class {
    var name: String { get }
    var collectionView: TagCollectionView { get }
}


class FiltersTableViewCellVM: FiltersTableViewCellVMType {
    
    var name: String
    var collectionView: TagCollectionView
    
    init(name: String, cells: [TagModel]) {
        self.name = name
        collectionView = TagCollectionView(cells: cells)
    }
    
}
