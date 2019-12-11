//
//  ProjectARViewController.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//


import UIKit
import ARKit
import GameplayKit

class ProjectARViewController: UIViewController, StoryboardInitializable {
    
    var catalogViewController: ProjectCatalogViewController?
    var projectViewController: ProjectsViewController?
    
    
    
    var viewModel: ProjectARViewModel?
    var arFacade: ARFacade?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        
        
        guard let viewModel = viewModel else { return }
        view.addSubview(viewModel.controls)
        viewModel.controls.fillSuperview()
        viewModel.controls.delegate = self
        
        
        arFacade = ARFacade(viewModel: viewModel)
        guard let arFacade = arFacade else { return }
        arFacade.onWallTapDelegate = self
        arFacade.runARSession()
        arFacade.delegate = UserCoaching(coachingLabel: viewModel.controls.coachingLabel, arFacade: arFacade)
        
    }  
}



//MARK: - ProjectARViewControlsDelegate

extension ProjectARViewController: ProjectARViewControlsDelegate {
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func plus() {
        arFacade?.wallBuilder.addPointer()
    }
    
    func undo() {
        arFacade?.wallBuilder.undo()
    }
    
    func done() {
        arFacade?.wallBuilder.buildWall()
    }
    
    func restart() {
        arFacade?.resetTracking()
    }
}


//MARK: - ARFacadeWallTapDelegate
extension ProjectARViewController: ARFacadeWallTapDelegate {
    func onTap() {
   
        catalogViewController = ProjectCatalogViewController()
        guard let viewController = catalogViewController, let viewModel = viewModel else { return }
        viewController.viewModel = ProjectCatalogViewControllerVM(projectId: viewModel.getProjectId())
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
}



//MARK: - ProjectCatalogViewDelegate
extension ProjectARViewController: ProjectCatalogViewDelegate {
   
    
    func showProjectsScreen() {
        
    

        guard let viewModel = viewModel else { return }
        let viewController = ProjectsViewController()
        viewController.viewModel = ProjectsViewControllerViewModel(projectId: viewModel.getProjectId())
        self.present(viewController, animated: true, completion: nil)
    }
    
    func didSelectItemAt(_ item: Goods) {
        
        
        catalogViewController?.dismiss(animated: true, completion: { [weak self] in
            guard let picture = item.picture else { return }
            let image = WebImageView()
            image.set(imageURL: picture)
            self?.arFacade?.wallBuilder.testureSegments(textureLength: 0.4625, textureWidth: 1, textureImage: image.image!)
        })
        
        
        
        
        
    }
}



