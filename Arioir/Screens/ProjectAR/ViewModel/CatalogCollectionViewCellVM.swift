//
//  CatalogCollectionViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol CatalogCollectionViewCellVMType: class {
    var label: String { get }
    var imageURL: String { get }
    var onSelectFavorites: (() -> Void)? { get set}
}



class CatalogCollectionViewCellVM: CatalogCollectionViewCellVMType {
    
    var onSelectFavorites: (() -> Void)?
    private var cell: ProjectItem
    
    var label: String {
        guard let name = cell.goods?.name else { return ""}
        return name
    }

    var imageURL: String {
        guard let picture = cell.goods?.picture else { return ""}
        return picture
    }
    
    init(cell: ProjectItem) {
        self.cell = cell
    }
}
