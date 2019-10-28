//
//  ProjectARViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



protocol ProjectARViewModelType {
    var controls: ProjectARViewControls { get }
}


class ProjectARViewModel: ProjectARViewModelType {
    
    
    
    private var project: Project
    
    
    var controls: ProjectARViewControls
    
    init(project: Project) {
        self.controls = ProjectARViewControls()
        self.project = project
    }
}



//MARK: - ViewModelUpdateProtocol
extension ProjectARViewModel: ViewModelUpdateProtocol {
    
    func updateHeightLabel(height: CGFloat) {
        controls.heightLabel.text = String(format: "%.2f", height) + " м"
    }
    
    func activateHeightLabel() {
        controls.heightLabel.isHidden = false
    }
    
    func deactivateHeightLabel() {
        controls.heightLabel.isHidden = true
    }
}

