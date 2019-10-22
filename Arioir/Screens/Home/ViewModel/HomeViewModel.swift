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
    
}

class HomeViewModel: HomeViewModelType {
    
    var collectionView: HomeCollectionView
    
    init() {
        collectionView = HomeCollectionView()
    }
}

