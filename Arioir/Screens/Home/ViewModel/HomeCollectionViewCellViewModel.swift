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
    var isFavorites: Bool { get }
    func updateFavoriteStatus()
}



class HomeCollectionViewCellViewModel: HomeCollectionViewCellViewModelType {
 
    
    var isFavorites: Bool = false
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
        checkIsFavorites()
    }
    
    fileprivate func checkIsFavorites() {
        guard let id = cell.id else { return }
        FavoriteService.read(id: id) { [weak self] (item) in
            self?.isFavorites = true
        }
    }
    
    // хз
    func updateFavoriteStatus() {
        print(#function)
        guard let id = cell.id else { return }
        if isFavorites {
            FavoriteService.delete(id: id) { [weak self] in
                
            }
            
        } else {
            FavoriteService.create(object: cell) { [weak self] in

            }
        }
    }
     
}
