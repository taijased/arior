//
//  FavoriteCollectionViewCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol FavoriteCollectionViewCellViewModelType: class {
    var label: String { get }
    var imageURL: String { get }
}

class FavoriteCollectionViewCellViewModel: FavoriteCollectionViewCellViewModelType {
    
    
    private var cell: FavoriteItem
    
    var label: String {
        guard let name = cell.name else { return ""}
        return name
    }
    
    var imageURL: String {
        guard let picture = cell.picture else { return ""}
        return picture
    }
    
    init(cell: FavoriteItem) {
        self.cell = cell
    }
}
