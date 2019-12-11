//
//  ProjectSettingsVC.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit


protocol ProjectCatalogViewDelegate: class {
    func didSelectItemAt(_ item: Goods)
    func showProjectsScreen()
}


class ProjectCatalogViewController: UIViewController {
    
    
    
    
    weak var delegate: ProjectCatalogViewDelegate?
    var viewModel: ProjectCatalogViewControllerVMType?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        view.backgroundColor = .white
        
        
        
        
        
        guard let viewModel = viewModel else { return }
        
        
        
        
        view.addSubview(viewModel.lineView)
        viewModel.lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        viewModel.lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewModel.lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewModel.lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        view.addSubview(viewModel.emptyLabel)
        viewModel.emptyLabel.topAnchor.constraint(equalTo: viewModel.lineView.bottomAnchor).isActive = true
        viewModel.emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewModel.emptyLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        viewModel.emptyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
         
        view.addSubview(viewModel.collectionView)
        viewModel.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        viewModel.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        viewModel.collectionView.collectionDelegate = self
        
        
        view.addSubview(viewModel.projectLabel)
        viewModel.projectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding).isActive = true
        viewModel.projectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.projectLabel.topAnchor.constraint(equalTo: viewModel.lineView.bottomAnchor, constant: 22).isActive = true
        viewModel.projectLabel.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        
    }

}


//MARK: - UIViewControllerTransitioningDelegate

extension ProjectCatalogViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentController = PresentationCatalogViewController(presentedViewController: presented, presenting: presenting)
        presentController.closeDelegate = self
        return presentController
    }
}



//MARK: - UIViewControllerTransitioningDelegate

extension ProjectCatalogViewController: PresentationCatalogViewControllerDelegate {
    func swipeDirection(_ direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
        case .down:
            self.dismiss(animated: true, completion: nil)
        case .up:
            self.dismiss(animated: true, completion: nil)
            delegate?.showProjectsScreen()
        case .left: break
        case .right: break
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


//MARK: - ProjectGoodsCollectionViewDelegate
extension ProjectCatalogViewController: ProjectGoodsCollectionViewDelegate{
    
    func didSelectItemAt() {
        guard let item = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        delegate?.didSelectItemAt(item)
    }
    
    func updateData() {
        viewModel?.collectionView.reloadData()
    }
      
}

