//
//  HomeCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift


protocol HomeCollectionViewViewModelType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForHeader() -> CGSize
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> Goods?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
}





class HomeCollectionViewViewModel: HomeCollectionViewViewModelType {
   

    var onReloadData: (() -> Void)?

    private var dataFetcherService = DataFetcherService()
    private var selectedIndexPath: IndexPath?
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 40.0
    
    var cells: Results<Goods>?
    
    init() {
//        self.dataFetcherService.fetchRSSAppleMusic { [weak self ](feed) in
//            self?.cells = feed?.feed.results ?? nil
//            self?.onReloadData?()
//        }
        
        cells = realm.objects(Goods.self)
    }
    
    
    func sizeForItemAt() -> CGSize {
        let width = (UIScreen.main.bounds.width - 60) * 0.5
        let height = (width * 2) / 3
        
        return CGSize(width: width, height: height)
    }
    
    func sizeForHeader() -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 190)
    }

    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeCollectionViewCellViewModelType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return HomeCollectionViewCellViewModel(cell: cell)
    }
    
    func viewModelForSelectedRow() -> Goods? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    
}
