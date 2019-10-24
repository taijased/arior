//
//  CardViewController.swift
//  ARI_UI
//
//  Created by Maxim Spiridonov on 30/07/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate: class {
    func toOrderFinished()
}


class CardViewController: UIViewController {
    
    weak var delegate: CardViewControllerDelegate?
    var viewModel: CardViewModelType?
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        viewModel?.onNavigation = { [weak self] type in
            self?.navigation(type: type)
        }
        
        guard let viewModel = viewModel else { return }
        
       
        view.addSubview(cardView)
        cardView.fillSuperview()
        
        
        cardView.addSubview(viewModel.cardTableView)
        viewModel.cardTableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        viewModel.cardTableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        viewModel.cardTableView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        viewModel.cardTableView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        
        view.addSubview(viewModel.cardVCBottomControls)
        viewModel.cardVCBottomControls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.cardVCBottomControls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.cardVCBottomControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.cardVCBottomControls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
               
        
    }
    
    fileprivate func navigation(type: CardModel) {
        switch type {
        case .openAR:
            let viewController = ARPreviewViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
            
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.toOrderFinished()
    }
}
