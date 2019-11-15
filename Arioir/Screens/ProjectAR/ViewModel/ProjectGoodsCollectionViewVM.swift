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
    func contextMenuActions(type: CatalogSettingsContextViewMenuEnum, projectId: String)
    func isEmpty() -> Bool
    var projectId: String { get set }
    var projectName: String { get set }
    var onReloadData: (() -> Void)? { get set }
}

class ProjectGoodsCollectionViewVM: ProjectGoodsCollectionViewVMType {
    
    
    var onReloadData: (() -> Void)?
    private var selectedIndexPath: IndexPath?
    var minimumInteritemSpacingForSectionAt: CGFloat = 20.0
    var minimumLineSpacingForSectionAt: CGFloat = 20.0
    var cells: List<Goods>?
    var projectId: String
    var projectName: String
    
    init(projectId: String) {
        self.projectId = projectId
        self.projectName = "Название проекта"
        fetchData()
    }

    fileprivate func fetchData() {

        ProjectsService.read(id: projectId) { [weak self] (project) in
            guard
                let cells = project?.goods
            else {
 
                return
            }
            self?.cells = cells
            self?.projectName = project!.name!
            self?.onReloadData?()
        }
    }
    
    func isEmpty() -> Bool {
        return cells?.isEmpty ?? true
    }
    
    func sizeForItemAt() -> CGSize {
        return CGSize(width: 160, height: 100)
    }
    
    
    func numberOfRows() -> Int {
        return cells?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ProjectGoodsCollectionViewCellVMType? {
        guard let cells = cells else { return nil }
        let cell = cells[indexPath.row]
        return ProjectGoodsCollectionViewCellVM(goods: cell)
    }
    
    func viewModelForSelectedRow() -> Goods? {
        guard let selectedIndexPath = selectedIndexPath, let cells = cells  else { return nil }
        return cells[selectedIndexPath.row]
    }
    
    
    func selectItem(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    
    func contextMenuActions(type: CatalogSettingsContextViewMenuEnum, projectId: String) {

        guard
            let selectedIndexPath = selectedIndexPath,
            let cells = cells,
            let id = cells[selectedIndexPath.row].id
            else { return }
        switch type {

        case .delete:
            ProjectsService.deleteProjectItem(projectId: projectId, elementId: id) {
                DispatchQueue.main.async {
                    self.onReloadData?()
                }
            }
        }
    }
    
    
}
