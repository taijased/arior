//
//  ProjectsViewControllerViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol ProjectsViewControllerViewModelType {
    var collectionView: CatalogCollectionView { get }
    var homeBottomControls: ProjectsBottomControls { get }
    var onNavigation: ((HomeNavigation) -> Void)? { get set }
    var projectId: String { get set }
    func updateCollection()
    
}

class ProjectsViewControllerViewModel: ProjectsViewControllerViewModelType {
    
    
    var projectId: String
    var onNavigation: ((HomeNavigation) -> Void)?
    var homeBottomControls: ProjectsBottomControls
    var collectionView: CatalogCollectionView
    
    
    
    
    init(projectId: String) {
        self.projectId = projectId
        
        collectionView = CatalogCollectionView()
        collectionView.viewModel = CatalogCollectionViewViewModel(projectId: projectId)
            
        homeBottomControls = ProjectsBottomControls()
        homeBottomControls.delegate = self
       
        
        updateLabel()
    }
    
    func updateLabel() {
        let favoriteCount = "\(realm.objects(FavoriteItem.self).count)"
        DispatchQueue.main.async {
            self.homeBottomControls.favoritesButton.updateLabel(newValue: favoriteCount)
        }
    }
    
    func updateCollection() {
        collectionView.reloadData()
    }
}


//MARK: - ProjectsBottomControlsDelegate

extension ProjectsViewControllerViewModel: ProjectsBottomControlsDelegate {
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
}
