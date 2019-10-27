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
    
    let cells = [CreateTableTextfieldCell(), CreateTableTextfieldCell(), CreateTableTextfieldCell()]
    
    
    
    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 80.0
        case 1:
            return 52.0
        default:
            return 80.0
        }
    }
    
    init(price: Float) {
        self.price = "\(price)"
    }
    
}
