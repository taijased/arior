//
//  ProjectsViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 12.11.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import RealmSwift

class ProjectsViewController: UIViewController, StoryboardInitializable {
    
    var viewModel: ProjectsViewControllerViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onNavigation = { [weak self] type in
            self?.navigation(type)
        }
        setupUI()
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
        
    }
    
    fileprivate func navigation(_ type: HomeNavigation) {
        switch type {
        case .filtres:
            self.dismiss(animated: true, completion: nil)
        case .favorites:
            let viewController = FavoriteViewController.initFromStoryboard(name: "Main")
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        case .favoritesEmpty(let errorTitle):
            self.showToast(errorTitle)
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    fileprivate func showToast(_ title: String) {
        let toast = ToastViewController(title: title)
        self.present(toast, animated: true)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            toast.dismiss(animated: true)
        }
    }
}

//MARK: - FavoriteViewControllerDelegate

extension ProjectsViewController: FavoriteViewControllerDelegate {
    func deinitController() {
        self.viewModel?.updateLabel()
        self.viewModel?.updateCollection()
    }
}





//MARK: - CatalogCollectionViewDelegate

extension ProjectsViewController: CatalogCollectionViewDelegate {
//    func updateData() {
//        self.viewModel?.updateCollection()
//    }
//    
    func selectItem() {

        guard let viewModel = viewModel, let goods = viewModel.collectionView.viewModel?.viewModelForSelectedRow()?.goods else { return }
        ProjectsService.addNewProjectItem(projectId: viewModel.projectId, projectItem: goods) { [weak self] in
            self?.viewModel?.updateCollection()
        }
    }
    
    func selectProject(project: Project) {
        print(#function)
    }
}
