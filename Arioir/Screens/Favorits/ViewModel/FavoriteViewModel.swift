//
//  FavoriteViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



protocol FavoriteViewModelType {
    var collectionView: FavoriteCollectionView { get }
    var bottomControls: FavoriteBottomControls { get }
    var onNavigation: ((FavoriteNavigation) -> Void)? { get set }
    func clearFavorites()
    var onActionSheet: ((UIAlertController) -> Void)? { get set }
}

class FavoriteViewModel: FavoriteViewModelType {
    
    var onActionSheet: ((UIAlertController) -> Void)?
    
    var bottomControls: FavoriteBottomControls
    var onNavigation: ((FavoriteNavigation) -> Void)?
    var collectionView: FavoriteCollectionView
    
    let storageManager: FavoriteServiceType?
    
    
    init() {
        storageManager = FavoriteService()
        
        collectionView = FavoriteCollectionView()
        bottomControls = FavoriteBottomControls()
        bottomControls.delegate = self
    }
    
    func clearFavorites() {
        guard let storageManager = storageManager else { return }
        storageManager.clearAll { [weak self] in
            self?.onNavigation?(.dissmis)
        }
    }
}


//MARK - FavoriteBottomControlsDelegate

extension FavoriteViewModel: FavoriteBottomControlsDelegate {
    func refresh() {
       
        let alert = UIAlertController(title: "Хотите удалить все из избранного?", message: "", preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (_) in
            guard let storageManager = self.storageManager else { return }
            storageManager.clearAll { [weak self] in
                self?.onNavigation?(.dissmis)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in }))
        self.onActionSheet?(alert)
    }
    
    func toOrder() {
        guard let storageManager = storageManager else { return }
        storageManager.favoritesToBasket { [weak self] in
            self?.onNavigation?(.dissmis)
        }
    }
}
