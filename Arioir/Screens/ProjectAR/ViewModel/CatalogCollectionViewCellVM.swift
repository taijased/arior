//
//  CatalogCollectionViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit





protocol CatalogCollectionViewCellVMType: class {
    var label: String { get }
    var imageURL: String { get }
    var onSelectFavorites: (() -> Void)? { get set}
    var isFromFavorite: Bool { get }
    var isFromProject: Bool { get }
    func controlsAction(_ type: CatalogCellActionModel, completion: @escaping (Bool) -> Void )
}



class CatalogCollectionViewCellVM: CatalogCollectionViewCellVMType {
    
    var onSelectFavorites: (() -> Void)?
    private let cell: ProjectItem
    var isFromFavorite: Bool = false
    var isFromProject: Bool = false
    private let projectId: String
    
    var label: String {
        guard let name = cell.goods?.name else { return ""}
        return name
    }
    
    var imageURL: String {
        guard let picture = cell.goods?.picture else { return ""}
        return picture
    }
    
    init(cell: ProjectItem, projectId: String) {
        self.cell = cell
        self.projectId = projectId
        checkFromFavorites()
        checkFromProject()
    }
    
    fileprivate func checkFromFavorites() {
        guard let id = cell.goods?.id else { return }
        FavoriteService.read(id: id) { [weak self] (item) in
            guard let _ = item else { return }
            self?.isFromFavorite = true
        }
    }
    
    fileprivate func checkFromProject() {
        guard let id = cell.goods?.id else { return }
        ProjectItemService.read(projectId: projectId, projectItemId: id) { [weak self] (item) in
            guard let _ = item else { return }
            self?.isFromProject = true
        }
    }
    
    
    func controlsAction(_ type: CatalogCellActionModel, completion: @escaping (Bool) -> Void ) {
        guard let id = cell.id else { return }
        Vibration.success.vibrate()
        switch type {
        case .project:
            if isFromProject {
                ProjectsService.deleteProjectItem(projectId: projectId, elementId: id) {
                    completion(true)
                }
            } else {
                guard let goods = cell.goods else { return }
                ProjectsService.addNewProjectItem(projectId: projectId, projectItem: goods) {
                    completion(true)
                }
            }
        case .favorite:
            if isFromFavorite {
                FavoriteService.delete(id: id) {
                    completion(true)
                }
            } else {
                guard let goods = cell.goods else { return }
                FavoriteService.create(object: goods) {
                    completion(true)
                }
            }
        case .delete:
            ProjectsService.delete(id: id) {
                completion(true)
            }
        }
    }
}



