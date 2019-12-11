//
//  ProjectCatalogViewControllerVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 11.12.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import UIKit.UILabel



protocol ProjectCatalogViewControllerVMType {
    var collectionView: ProjectGoodsCollectionView { get }
    var onNavigation: ((HomeNavigation) -> Void)? { get set }
    var projectId: String { get }
    var lineView: UIView { get }
    var projectLabel: UILabel { get }
    var emptyLabel: UILabel { get }
}

class ProjectCatalogViewControllerVM: ProjectCatalogViewControllerVMType {
    
    
    
    
    var projectId: String
    var onNavigation: ((HomeNavigation) -> Void)?
    var collectionView: ProjectGoodsCollectionView
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Black.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    let projectLabel: UILabel = {
        let label = UILabel.H1.bold
        label.text = "Название проекта"
        return label
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel.H4.medium
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Начните добавлять товары ниже из каталога"
        return label
    }()

    

    init(projectId: String) {
        self.projectId = projectId
        collectionView = ProjectGoodsCollectionView()
        collectionView.viewModel = ProjectGoodsCollectionViewVM(projectId: projectId)
        projectLabel.text = collectionView.viewModel?.projectName
        collectionView.updateBackground()
    }
    

}

