//
//  ProjectsContextViewMenu.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



enum ProjectsContextMenuEnum {
    case delete
}

protocol ProjectsContextViewMenu {
    
}

extension ProjectsContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (ProjectsContextMenuEnum) -> Void) -> UIMenu {

        let delete = UIAction(title: "Удалить проект", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            completion(.delete)
        }
        
        return UIMenu(title: "", children: [delete])
    }
}
