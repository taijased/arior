//
//  CatalogHeaderViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol CatalogHeaderViewCellVMlType: class {
    var viewModel: ProjectGoodsCollectionViewVMType { get }
    var projectId: String { get set }
    var projectName: String? { get set }
}


class CatalogHeaderViewCellVM: CatalogHeaderViewCellVMlType {
    
    var projectId: String
    var projectName: String?
    var viewModel: ProjectGoodsCollectionViewVMType
    
    init(projectId: String) {
        
        self.projectId = projectId
        viewModel = ProjectGoodsCollectionViewVM(projectId: projectId)
//        collectionView = ProjectGoodsCollectionView(projectId: projectId)
        projectName = viewModel.projectName
    }
}
