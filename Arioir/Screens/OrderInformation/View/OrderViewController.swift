//
//  OrderViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, StoryboardInitializable {

    var viewModel: OrderViewModelType?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        view.backgroundColor = .white
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
    }

}
