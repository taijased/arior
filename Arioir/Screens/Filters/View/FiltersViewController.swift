//
//  FiltersViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 15.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, StoryboardInitializable {
    
    fileprivate var viewModel: FiltersViewControllerVMType?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FiltersViewControllerVM()
        setupUI()

    }
    
    fileprivate func setupUI() {
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
    }
}


