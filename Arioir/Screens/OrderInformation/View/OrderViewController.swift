//
//  OrderViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol OrderViewControllerDelegate: class {
    func deinitController()
}


class OrderViewController: UIViewController, StoryboardInitializable {

    var viewModel: OrderViewModelType?
    weak var delegate: OrderViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        view.backgroundColor = .white
        viewModel?.onFinished = { [weak self] in
            self?.showAlert()
        }
        
        
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.tableView)
        viewModel.tableView.fillSuperview()
        
        view.addSubview(viewModel.control)
        viewModel.control.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.control.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.control.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.control.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
    }

    fileprivate func showAlert() {
        let toast = ToastViewController(title: "Заказ оформлен!")
        toast.delegate = self
        self.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
}

extension OrderViewController: ToastViewControllerDelegate {
    func deinitController() {
        self.dismiss(animated: true, completion: nil)
    }
}

