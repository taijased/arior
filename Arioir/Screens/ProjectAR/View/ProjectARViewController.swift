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
        
       
        setupCatalog()
    }
    
    
    func setupCatalog() {
        
        
    }
    
}



//MARK: - ProjectARViewControlsDelegate

extension ProjectARViewController: ProjectARViewControlsDelegate {
    
    func close() {
        print(#function)
        self.dismiss(animated: true, completion: nil)
        //        catalogViewController.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        //        let viewController = ProjectViewController.initFromStoryboard(name: "Main")
        //        self.present(viewController, animated: true, completion: nil)
        
        
//        projectVC.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: projectVC.catalogHeight)
        
//         projectVC.view.frame  = CGRect(x: 0, y: projectVC.view.frame.size.height - 300, width: projectVC.view.bounds.width, height: 300)
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
        print("tapped")
        //        let viewController = CreateViewController()
        //        self.present(viewController, animated: true, completion: nil)
    }
    
}


