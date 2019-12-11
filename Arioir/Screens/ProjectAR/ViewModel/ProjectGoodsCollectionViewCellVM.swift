//
//  ProjectGoodsCollectionViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import Foundation



protocol ProjectGoodsCollectionViewCellVMType: class {
    var label: String { get }
    var iconName: String { get }
    func controlsAction(_ type: CatalogCellActionModel, completion: @escaping (Bool) -> Void )
}

class ProjectGoodsCollectionViewCellVM: ProjectGoodsCollectionViewCellVMType {

    private let goods: Goods
    private let projectId: String
    
       
    var label: String {
        return goods.name ?? ""
    }

    var iconName: String {
        return goods.picture ?? ""
    }
    
    
    init(goods: Goods, projectId: String) {
        self.goods = goods
        self.projectId = projectId
    }
    
    func controlsAction(_ type: CatalogCellActionModel, completion: @escaping (Bool) -> Void ) {
        
        
        guard let id =  goods.id else { return }
        
        switch type {
        case .delete:
            ProjectsService.deleteProjectItem(projectId: projectId, elementId: id) {
                Vibration.success.vibrate()
                completion(true)
            }
        case .project:
            print("same")
        case .favorite:
            print("same")
        }
    }
}
