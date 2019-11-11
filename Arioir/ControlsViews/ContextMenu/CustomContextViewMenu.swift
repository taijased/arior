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
}

protocol CustomContextViewMenu {
    
}

extension CustomContextViewMenu {
    func makeDefaultDemoMenu(completion: @escaping (FavoriteContextMenuEnum) -> Void) -> UIMenu {


        
        let toOrder = UIAction(title: "Положить в корзину", image: UIImage(named: "cart-black")) { action in
            completion(.toOrder)
        }

        
        let delete = UIAction(title: "Удалить из избранное", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            completion(.delete)
        }

        
        return UIMenu(title: "", children: [toOrder, delete])
    }
}
