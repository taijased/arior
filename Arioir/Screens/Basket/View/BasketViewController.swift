//
//  BasketViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 23.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit

protocol BasketViewControllerDelegate: class {
    func deinitController()
}


class BasketViewController: UIViewController, StoryboardInitializable {
    
    
    weak var delegate: BasketViewControllerDelegate?
    let viewModel = BasketViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .purple
        setupTableView()
        setupControls()
    }
    
    fileprivate func setupTableView() {
        view.addSubview(viewModel.basketTableView)
        viewModel.basketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.basketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.basketTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewModel.basketTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    fileprivate func setupControls() {
        view.addSubview(viewModel.controlsView)
        viewModel.controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.controlsView.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        viewModel.controlsView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
}

//MARK: - BasketViewControlsDelegate

extension BasketViewController: BasketViewControlsDelegate {
    func refresh() {
        print(#function)
    }
    
    func toOrder() {
        
        let viewController = OrderViewController()
        viewController.delegate = self
        viewController.viewModel = OrderViewModel(price: viewModel.basketTableView.getAllItemPrices())
        self.present(viewController, animated: true, completion: nil)
    }
    
}

extension BasketViewController: OrderViewControllerDelegate {
    func deinitController() {
        self.dismiss(animated: true, completion: nil)
    }
}
