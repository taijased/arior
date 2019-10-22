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
    }

    
    func selectItem() {
        guard let goods = viewModel?.collectionView.viewModel?.viewModelForSelectedRow() else { return }
        print(goods)
    }
}
