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
    var control: OrderBottomControl { get }
    var onFinished: (() -> Void)? { get set }
}



class OrderViewModel: OrderViewModelType {
    var onFinished: (() -> Void)?
    
    var control: OrderBottomControl
    var tableView: OrderTableView
    
    init(price: Float) {
        tableView = OrderTableView()
        tableView.viewModel = OrderTableViewViewModel(price: price)
        
        control = OrderBottomControl()
        control.delegate = self
    }
}

//MARK: - OrderBottomControlDelegate
extension OrderViewModel: OrderBottomControlDelegate {
    func toOrder() {
        self.onFinished?()
    }
}
