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
        
        view.addSubview(viewModel.controls)
        
        viewModel.controls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.controls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.controls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.controls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        viewModel.controls.delegate = self
    }
}


//MARK: - FilterBottomControlsDelegate


extension FiltersViewController: FilterBottomControlsDelegate {
    func refresh() {
        print(#function)
        
    }
    
    func toShow() {
        guard let tags = viewModel?.tableView.viewModel?.getTappedTag() else { return }
        StorageManager.filter(tags) { (goods) in
            print(goods)
        }
        
    }
}


