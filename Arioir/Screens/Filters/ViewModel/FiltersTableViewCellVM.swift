//
//  FiltersTableViewCellVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol FiltersTableViewCellVMType: class {
    var name: String { get }
}


class FiltersTableViewCellVM: FiltersTableViewCellVMType {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
