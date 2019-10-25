//
//  HomeCollectionViewCellViewModel.swift
//  mvvm
//
//  Created by Максим Спиридонов on 21.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol HomeCollectionViewCellViewModelType: class {
    var label: String { get }
    var imageURL: String { get }
    var onSelectFavorites: (() -> Void)? { get set}
}



class HomeCollectionViewCellViewModel: HomeCollectionViewCellViewModelType {
    
    var onSelectFavorites: (() -> Void)?
    private var cell: Goods
    
    var label: String {
        guard let name = cell.name else { return ""}
        return name
    }

    var imageURL: String {
        guard let picture = cell.picture else { return ""}
        return picture
    }
    
    init(cell: Goods) {
        self.cell = cell
    }
}
