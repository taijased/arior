//
//  IconCollectionViewCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation

protocol IconCollectionViewCellViewModelType: class {
    var selected: Bool { get }
    var iconName: String { get }
}

class IconCollectionViewCellViewModel: IconCollectionViewCellViewModelType {
    
    
    private var cell: (name: String, selected: Bool)
    

    var iconName: String {
        return self.cell.name
    }
    
    var selected: Bool {
        return self.cell.selected
    }
    
    
    init(cell: (name: String, selected: Bool)) {
        self.cell = cell
    }
    
    init(_ name: String, _ selected: Bool) {
        self.cell.name = name
        self.cell.selected = selected
    }
}
