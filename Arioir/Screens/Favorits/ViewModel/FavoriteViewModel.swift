//
//  FavoriteViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol FavoriteViewModelType {
    var collectionView: FavoriteCollectionView { get }
    var bottomControls: FavoriteBottomControls { get }
    var onNavigation: ((FavoriteNavigation) -> Void)? { get set }
}

class FavoriteViewModel: FavoriteViewModelType {
    
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
    
}


//MARK - FavoriteBottomControlsDelegate

extension FavoriteViewModel: FavoriteBottomControlsDelegate {
    func refresh() {
        guard let storageManager = storageManager else { return }
        storageManager.clearFavorites { [weak self] in
            self?.onNavigation?(.dissmis)
        }
    }
    
    func toOrder() {
        guard let storageManager = storageManager else { return }
        storageManager.favoritesToBasket { [weak self] in
            self?.onNavigation?(.dissmis)
        }
    }
}
