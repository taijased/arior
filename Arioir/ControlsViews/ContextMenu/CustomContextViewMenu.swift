//
//  CustomContextViewMenu.swift
//  Arioir
//
//  Created by Максим Спиридонов on 09.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit



enum FavoriteContextMenuEnum {
    case toOrder
    case delete
    case toProject
}

protocol CustomContextViewMenu {
    
}

extension CustomContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (FavoriteContextMenuEnum) -> Void) -> UIMenu {


        
        let toOrder = UIAction(title: "Положить в корзину", image: UIImage(named: "cart-black")) { action in
            completion(.toOrder)
        }
        let toProject = UIAction(title: "Положить в проект", image: UIImage(named: "plus-dark")) { action in
            completion(.toProject)
        }

        
        let delete = UIAction(title: "Удалить из избранное", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            completion(.delete)
        }

        
        return UIMenu(title: "", children: [toOrder, toProject, delete])
    }
}
