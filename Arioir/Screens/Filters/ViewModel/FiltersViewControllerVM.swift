//
//  FiltersViewControllerVM.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation




protocol FiltersViewControllerVMType {
    var tableView: FiltersTableView { get set }
    var controls: FilterBottomControls { get set }
}

class FiltersViewControllerVM: FiltersViewControllerVMType {
    
    var tableView: FiltersTableView
    var controls: FilterBottomControls
    
    init() {
        tableView = FiltersTableView()
        controls = FilterBottomControls()
    }
}
