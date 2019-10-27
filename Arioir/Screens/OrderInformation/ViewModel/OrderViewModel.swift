//
//  OrderViewModel.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation


protocol OrderViewModelType {
    var tableView: OrderTableView { get }
    
}

class OrderViewModel: OrderViewModelType {
    
    
    var tableView: OrderTableView
    init(price: Float) {
        tableView = OrderTableView()
        tableView.viewModel = OrderTableViewViewModel(price: price)
    }
}
