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
    var isFromProject: Bool { get }
    func controlsAction(_ type: FavoriteCellModel, completion: @escaping (Bool) -> Void)
}

class FavoriteCollectionViewCellViewModel: FavoriteCollectionViewCellViewModelType {
    
    private var cell: FavoriteItem
    var isFromProject: Bool = false
    
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
        checkFromProject()
    }
    
    fileprivate func checkFromProject() {
        
        guard let id = cell.id else { return }
        ProjectItemService.read(id: id) { [weak self] (item) in
            self?.isFromProject = true
        }
    }
    
    func controlsAction(_ type: FavoriteCellModel, completion: @escaping (Bool) -> Void ) {
        guard let id = cell.id else { return }
        Vibration.success.vibrate()
        switch type {
        case .favorite:
            FavoriteService.delete(id: id) {
                completion(FavoriteService.isEmpty())
            }
        case .cart:
            BasketService.favoritesToBasket(id: id) {
                completion(FavoriteService.isEmpty())
            }
        case .project:
            if isFromProject {
                ProjectsService.delete(id: id) {
                    completion(false)
                }

            } else {
                ProjectsService.create(id: id) {
                    completion(false)
                }
            }
        }
    }
    
}
