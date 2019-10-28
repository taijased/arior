//
//  ToastViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 27.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol ToastViewControllerDelegate: class {
    func deinitController()
}


class ToastViewController: UIViewController {
    
    weak var delegate: ToastViewControllerDelegate?
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
        view.backgroundColor = .black
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension ToastViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentController = ToastPresentationController(presentedViewController: presented, presenting: presenting)
        presentController.closeDelegate = self
        
        return presentController
    }
}


extension ToastViewController: ToastPresentationControllerDelegate {
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
