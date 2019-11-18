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
    
    init(name: String) {
        self.name = name
        
        let tagCells = [TagModel(label: "Стеклярус на флизелине", status: true),
                        TagModel(label: "Текстиль", status: true),
                        TagModel(label: "Бумага", status: false),
                        TagModel(label: "Винил с флоком", status: false),
                        TagModel(label: "Бумага с акрилом", status: true),
                        TagModel(label: "Лак, акрил", status: false),
                        TagModel(label: "Винил", status: true),
                        TagModel(label: "Флизелин с акриловым напылением", status: true),
                        TagModel(label: "Винил", status: false),
                        TagModel(label: "Лак, акрил", status: false),
                        TagModel(label: "Стеклярус на флизелине", status: true),
                        TagModel(label: "Винил", status: false),
                        TagModel(label: "Lak", status: true)]
        
        collectionView = TagCollectionView(cells: tagCells)
    }
    
}
