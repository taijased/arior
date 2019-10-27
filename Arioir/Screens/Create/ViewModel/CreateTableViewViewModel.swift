//
//  CreateTableViewViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 26.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit





protocol CreateTableViewViewModelType {
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func numberOfRowsInSection() -> Int
    
}

class CreateTableViewViewModel: CreateTableViewViewModelType {
    
    
    
    let cells = [CreateTableTextfieldCell(), CreateTableTextfieldCell(), CreateTableTextfieldCell()]
    
    
    
    func numberOfRowsInSection() -> Int {
        return cells.count
    }

    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60.0
        case 1:
            return 120.0
        default:
            return 120.0
        }
    }
    
}
