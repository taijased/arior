//
//  FavoriteViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 24.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol FavoriteViewControllerDelegate: class {
    func deinitController()
}

class FavoriteViewController: UIViewController, StoryboardInitializable {
    
    
    weak var delegate: FavoriteViewControllerDelegate?
    var viewModel: FavoriteViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoriteViewModel()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        viewModel?.onNavigation = { [weak self] type in
            self?.navigation(type)
        }
        viewModel?.onActionSheet = { [weak self] alert in
            self?.present(alert, animated: true, completion: nil)
        }
        
        
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.collectionView)
        viewModel.collectionView.fillSuperview()
        viewModel.collectionView.collectionDelegate = self
        
        view.addSubview(viewModel.bottomControls)
        viewModel.bottomControls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.bottomControls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.bottomControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.bottomControls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        
        
    }
    
    fileprivate func showToast(_ title: String) {
        let toast = ToastViewController(title: title)
        self.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
    
    fileprivate func navigation(_ type: FavoriteNavigation) {
        switch type {
        case .dissmis:
            self.dismiss(animated: true, completion: nil)
        case .alert(let title):
            self.showToast(title)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.deinitController()
    }
}


//MARK - FavoriteCollectionViewDelegate

extension FavoriteViewController: FavoriteCollectionViewDelegate {
    func showAlert(_ type: FavoriteNavigation) {
        self.navigation(type)
    }
    
    func dismisController() {
        self.navigation(.dissmis)
    }
    
    func selectItem() {
        print(#function)
    }
    
    func selectProject(project: Project) {
        print(#function)
    }
}

