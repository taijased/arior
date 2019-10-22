//
//  HomeHeaderViewCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol HomeHeaderViewCellViewModelType {
    var collectionView: ProjectsCollectionView { get }
}


class HomeHeaderViewCellViewModel: HomeHeaderViewCellViewModelType {
    var collectionView: ProjectsCollectionView

    init() {
        collectionView = ProjectsCollectionView()
    }
    
}
