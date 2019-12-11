//
//  ProjectsCollectionViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import RealmSwift


protocol ProjectsCollectionViewViewModelType {
    var minimumInteritemSpacingForSectionAt: CGFloat { get }
    var minimumLineSpacingForSectionAt: CGFloat { get }
    func sizeForItemAt() -> CGSize
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellViewModelType?
    func viewModelForSelectedRow() -> Project?
    func selectItem(atIndexPath indexPath: IndexPath)
    var onReloadData: (() -> Void)? { get set }
    func contextMenuActions(type: ProjectsContextMenuEnum)
}

class ProjectsCollectionViewViewModel: ProjectsCollectionViewViewModelType {
    
    
    
    var onReloadData: (() -> Void)?
    private var selectedIndexPath: IndexPath?
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 20.0
    var cells: Results<Project>?
    
    init() {
        updateItems()
    }
    
    fileprivate func updateItems() {
        ProjectsService.addDefaultProject { [weak self] in
            self?.cells = realm.objects(Project.self)
            self?.onReloadData?()
        }
    }
    
    
    func sizeForItemAt() -> CGSize {
        return CGSize(width: 160, height: 100)
    }
    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectsCollectionViewCellViewModelType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return ProjectsCollectionViewCellViewModel(project: cell)
    }
    
    func viewModelForSelectedRow() -> Project? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    func contextMenuActions(type: ProjectsContextMenuEnum) {
        guard
            let selectedIndexPath = selectedIndexPath,
            let cells = cells,
            let id = cells[selectedIndexPath.row].id
            else { return }
        
        switch type {
            
        case .delete:
            if id == "1" {
                return
            } else {
                ProjectsService.delete(projectId: id) { [weak self] in
                    self?.onReloadData?()
                }
            }
            
        }
    }
    
    
}
