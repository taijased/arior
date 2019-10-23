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
        print("ololo")
        let newValue = "\(realm.objects(BasketItem.self).count)"
  
        DispatchQueue.main.async {
            self.homeBottomControls.cartButton.updateLabel(newValue: newValue)
        }
      
    }
}




//MARK: - HomeBottomControlsDelegate

extension HomeViewModel: HomeBottomControlsDelegate {
    func onTappedFilter() {
        self.onNavigation?(.filtres)
    }
    
    func onTappedFavorites() {
        self.onNavigation?(.favorites)
    }
    
    func onTappedCart() {
        self.updateLabel()
        
        self.onNavigation?(.basket)
    }
}
