//
//  CatalogHeaderViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol CatalogHeaderViewCellVMlType {
    var collectionView: ProjectGoodsCollectionView { get }
    var projectId: String { get set }
    var projectName: String? { get set }

}


class CatalogHeaderViewCellVM: CatalogHeaderViewCellVMlType {
    
    var projectId: String
    var projectName: String?
    var collectionView: ProjectGoodsCollectionView

    init(projectId: String) {
        
        self.projectId = projectId
        collectionView = ProjectGoodsCollectionView()
        getCells()
    }
    
    fileprivate func getCells() {
        ProjectsService.read(id: projectId) { (project) in
            guard let cells = project?.goods else { return }
            self.collectionView.viewModel = ProjectGoodsCollectionViewVM(cells: cells, projectId: self.projectId)
            self.projectName = project!.name!
        }
    }
    
}
