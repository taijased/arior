//
//  CatalogCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift


protocol CatalogCollectionViewViewModelType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForHeader() -> CGSize
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CatalogCollectionViewCellVMType?
    func cellHeaderViewModel() -> CatalogHeaderViewCellVMlType?
    func viewModelForSelectedRow() -> ProjectItem?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    var onUpdateLabel: (() -> Void)? { get set }
    var projectId: String { get set }
    func updateLabel()
    func isEmpty() -> Bool
    
}





class CatalogCollectionViewViewModel: CatalogCollectionViewViewModelType {
    
    var projectId: String
    var onReloadData: (() -> Void)?
    var onUpdateLabel: (() -> Void)?
    
    private var dataFetcherService = DataFetcherService()
    private var selectedIndexPath: IndexPath?
    
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 40.0
    
    var cells: Results<ProjectItem>?
    
    init(projectId: String) {
        self.projectId = projectId
        cells = realm.objects(ProjectItem.self)
        self.onReloadData?()
        updateLabel()
    }
    
    
    func sizeForItemAt() -> CGSize {
        let width = (UIScreen.main.bounds.width - 60) * 0.5
        let height = (width * 2) / 3
        
        return CGSize(width: width, height: height)
    }
    
    func sizeForHeader() -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: 250)
    }
    
    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CatalogCollectionViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return CatalogCollectionViewCellVM(cell: cell, projectId: projectId)
    }
    func cellHeaderViewModel() -> CatalogHeaderViewCellVMlType? {
        return CatalogHeaderViewCellVM(projectId: projectId)
    }
    
    func viewModelForSelectedRow() -> ProjectItem? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func updateLabel() {
        self.onUpdateLabel?()
    }
    
    func isEmpty() -> Bool {
        return cells?.isEmpty ?? true
    }
}
