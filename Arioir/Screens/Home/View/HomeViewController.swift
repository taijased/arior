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
//        testAPI()
    }
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .random()
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.collectionView)
        viewModel.collectionView.fillSuperview()
        viewModel.collectionView.collectionDelegate = self
        view.addSubview(viewModel.homeBottomControls)
        viewModel.homeBottomControls.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewModel.homeBottomControls.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewModel.homeBottomControls.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42).isActive = true
        viewModel.homeBottomControls.heightAnchor.constraint(equalToConstant: Constants.bottomSize).isActive = true
        viewModel.homeBottomControls.delegate = self
        
    }
    
    
    
    fileprivate func testAPI() {
        
        
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

//MARK: - HomeCollectionViewDelegate

extension HomeViewController: HomeCollectionViewDelegate {
    func selectProject(project: Project) {
        print(project)
        let viewController = ARViewController()
        viewController.modalPresentationStyle = .fullScreen 
        self.present(viewController, animated: true, completion: nil)
        
    }

    
    func selectItem() {
        guard let goods = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        let viewController = CardViewController()
        viewController.viewModel = CardViewModel()
        viewController.viewModel!.setItem(item: goods)
        self.present(viewController, animated: true, completion: nil)
        
    }
}



//MARK: - HomeBottomControlsDelegate

extension HomeViewController: HomeBottomControlsDelegate {
    func onTappedFilter() {
        print(#function)
    }
    
    func onTappedFavorites() {
        print(#function)
    }
    
    func onTappedCart() {
        print(#function)
    }
}
