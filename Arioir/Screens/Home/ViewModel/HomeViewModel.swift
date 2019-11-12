//
//  HomeViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation

protocol HomeViewModelType {
    var collectionView: HomeCollectionView { get }
    var homeBottomControls: HomeBottomControls { get }
    
    var onNavigation: ((HomeNavigation) -> Void)? { get set }
    func updateLabel()
    func updateCollection()
}

class HomeViewModel: HomeViewModelType {
    
    var onNavigation: ((HomeNavigation) -> Void)?
    var homeBottomControls: HomeBottomControls
    var collectionView: HomeCollectionView
    
    
    
    
    init() {
        
        collectionView = HomeCollectionView()
        homeBottomControls = HomeBottomControls()
        homeBottomControls.delegate = self
       
        
        updateLabel()
    }
    
    func updateLabel() {
        let basketCount = "\(realm.objects(BasketItem.self).count)"
        let favoriteCount = "\(realm.objects(FavoriteItem.self).count)"
        DispatchQueue.main.async {
            self.homeBottomControls.cartButton.updateLabel(newValue: basketCount)
            self.homeBottomControls.favoritesButton.updateLabel(newValue: favoriteCount)
        }
      
    }
    
    func updateCollection() {
        collectionView.reloadData()
    }
}


//MARK: - HomeBottomControlsDelegate

extension HomeViewModel: HomeBottomControlsDelegate {
    func onTappedFilter() {
        self.onNavigation?(.filtres)
    }
    
    func onTappedFavorites() {

        if FavoriteService.isEmpty() {
            self.onNavigation?(.favoritesEmpty(errorTitle: "Избранное пусто :("))
        } else {
            self.onNavigation?(.favorites)
        }
    }
    
    func onTappedCart() {
        if BasketService.isEmpty() {
            self.onNavigation?(.basketEmpty(errorTitle: "В корзине пусто :("))
        } else {
            self.updateLabel()
            self.onNavigation?(.basket)
        }
    }
}
