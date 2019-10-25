//
//  HomeViewController.swift
//  Demoksi
//
//  Created by Максим Спиридонов on 13.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit
import XMLCoder
import RealmSwift

class HomeViewController: UIViewController, StoryboardInitializable {
    
    var viewModel: HomeViewModelType?
    var dataFetcherService = DataFetcherService()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setupUI()
        testAPI()
    }
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .random()
        viewModel?.onNavigation = { [weak self] type in
            self?.navigation(type)
        }
        
        viewModel?.updateLabel()
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.collectionView)
        viewModel.collectionView.fillSuperview()
        viewModel.collectionView.collectionDelegate = self
        view.addSubview(viewModel.homeBottomControls)
        viewModel.homeBottomControls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.homeBottomControls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.homeBottomControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.homeBottomControls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        
        
    }
    

    
    
    
    fileprivate func testAPI() {
        
        if realm.isEmpty {
            print("realm.isEmpty")
            self.dataFetcherService.fetchWallpapers { (catalog) in
                for index in 1...20 {
                    let offer = catalog?.shop.offers.offers[index]
                    StorageManager.saveObject(Goods(offer: offer!)) {
                        print("compilete")
                    }
                }
            }
        }
        
    }
    
    fileprivate func navigation(_ type: HomeNavigation) {
        switch type {
            
        case .filtres:
            self.dismiss(animated: true, completion: nil)
        case .favorites:
            let viewController = FavoriteViewController.initFromStoryboard(name: "Main")
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        case .basket:
            let viewController = BasketViewController.initFromStoryboard(name: "Main")
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        case .arScene:
            self.dismiss(animated: true, completion: nil)
        case .dissmis:
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - HomeCollectionViewDelegate

extension HomeViewController: HomeCollectionViewDelegate {
    func selectProject(project: Project) {
        
        let viewController = CreateViewController()
//        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func selectItem() {
        guard let goods = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        let viewController = CardViewController()
        viewController.viewModel = CardViewModel()
        viewController.viewModel!.setItem(item: goods)
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
}


//MARK: - BasketViewControllerDelegate, FavoriteViewControllerDelegate, CardViewControllerDelegate

extension HomeViewController: BasketViewControllerDelegate, FavoriteViewControllerDelegate, CardViewControllerDelegate {
    func deinitController() {
        self.viewModel?.updateLabel()
    }
}


