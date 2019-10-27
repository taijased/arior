//
//  CreateViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 25.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol CreateViewModelType {
    var tableView: CreateTableView { get }
    
}

class CreateViewModel: CreateViewModelType {
    var tableView: CreateTableView
    init() {
        tableView = CreateTableView()
        
    }
}
