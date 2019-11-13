//
//  CatalogSettingsContextViewMenu.swift
//  Arioir
//
//  Created by Максим Спиридонов on 13.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

enum CatalogSettingsContextViewMenuEnum {
    case delete
}

protocol CatalogSettingsContextViewMenu {
    
}

extension CatalogSettingsContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (CatalogSettingsContextViewMenuEnum) -> Void) -> UIMenu {

        let delete = UIAction(title: "Удалить из проекта", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            completion(.delete)
        }
        
        return UIMenu(title: "", children: [delete])
    }
}
