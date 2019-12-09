//
//  FavoriteCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift


protocol FavoriteCollectionViewViewModelType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoriteCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> FavoriteItem?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    func actionsMenu(type: FavoriteContextMenuEnum, completion: @escaping (Bool) -> Void)
}





class FavoriteCollectionViewViewModel: FavoriteCollectionViewViewModelType {
    
    
    var onReloadData: (() -> Void)?
    
    private var dataFetcherService = DataFetcherService()
    private var selectedIndexPath: IndexPath?
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 40.0
    
    var cells: Results<FavoriteItem>?
    
    init() {
        
        //        self.dataFetcherService.fetchRSSAppleMusic { [weak self ](feed) in
        //            self?.cells = feed?.feed.results ?? nil
        //            self?.onReloadData?()
        //        }
        
        cells = realm.objects(FavoriteItem.self)
    }
    
    
    func sizeForItemAt() -> CGSize {
        let width = (UIScreen.main.bounds.width - 60) * 0.5
        let height = (width * 2) / 3
        
        return CGSize(width: width, height: height)
    }
    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FavoriteCollectionViewCellViewModelType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return FavoriteCollectionViewCellViewModel(cell: cell)
    }
    
    func viewModelForSelectedRow() -> FavoriteItem? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    func actionsMenu(type: FavoriteContextMenuEnum, completion: @escaping (Bool) -> Void) {
        guard
            let selectedIndexPath = selectedIndexPath,
            let cells = cells,
            let id = cells[selectedIndexPath.row].id
        else {
            completion(true)
            return
        }
        
        switch type {
        case .toOrder:
            BasketService.favoritesToBasket(id: id) { [weak self] in
                self?.onReloadData?()
                completion(FavoriteService.isEmpty())
            }
            
        case .delete:
            FavoriteService.delete(id: id) { [weak self] in
                self?.onReloadData?()
                completion(FavoriteService.isEmpty())
            }
        case .toProject:
            ProjectsService.create(id: id) { [weak self] in
                self?.onReloadData?()
                completion(FavoriteService.isEmpty())
            }
        }
    }
}
