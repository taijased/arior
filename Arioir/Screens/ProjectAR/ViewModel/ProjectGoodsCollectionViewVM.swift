//
//  ProjectGoodsCollectionViewVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//
//
//  ProjectsCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift


protocol ProjectGoodsCollectionViewVMType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectGoodsCollectionViewCellVMType?
    func viewModelForSelectedRow() -> Goods?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    func contextMenuActions(type: ProjectsContextMenuEnum)
    func isEmpty() -> Bool
}

class ProjectGoodsCollectionViewVM: ProjectGoodsCollectionViewVMType {
    
    
    var onReloadData: (() -> Void)?
    private var selectedIndexPath: IndexPath?
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 20.0
    var cells: List<Goods>
    
    init(cells: List<Goods>) {
        self.cells = cells
        self.onReloadData?()
    }

    
    func isEmpty() -> Bool {
        return cells.isEmpty
    }
    
    func sizeForItemAt() -> CGSize {
        return CGSize(width: 160, height: 100)
    }
    
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectGoodsCollectionViewCellVMType? {
        let cell = cells[indexPath.row]
        return ProjectGoodsCollectionViewCellVM(goods: cell)
    }
    
    func viewModelForSelectedRow() -> Goods? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    func contextMenuActions(type: ProjectsContextMenuEnum) {
        guard
            let selectedIndexPath = selectedIndexPath,
            let id = cells[selectedIndexPath.row].id
            else { return }
        
        switch type {
            
        case .delete:
            ProjectsService.delete(id: id) { [weak self] in
                self?.onReloadData?()
            }
        }
    }
    
    
}
