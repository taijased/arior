//
//  OrderTableViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit





protocol OrderTableViewViewModelType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRowsInSection() -> Int
    var price: String { get }
}

class OrderTableViewViewModel: OrderTableViewViewModelType {
    
    var price: String
    
    let cells = ["", "", "", "", "", "", "", "", ""]
    
    
    
    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 80.0
        case 1:
            return 62.0
        case 2:
            return 62.0
        case 3:
            return 62.0
        case 4:
            return 62.0
        case 5:
            return 62.0
        default:
            return 77.0
        }
    }
    
    init(price: Float) {
        self.price = "\(price)"
    }
    
}
