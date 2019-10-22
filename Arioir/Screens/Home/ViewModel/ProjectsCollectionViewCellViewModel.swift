//
//  ProjectsCollectionViewCellViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation



protocol ProjectsCollectionViewCellViewModelType: class {
    var label: String { get }
    var iconName: String { get }
}

class ProjectsCollectionViewCellViewModel: ProjectsCollectionViewCellViewModelType {

    private var project: Project
    
       
    var label: String {
        return project.name ?? ""
    }

    var iconName: String {
        return project.iconName ?? ""
    }
    
    
    init(project: Project) {
        self.project = project
    }
}
