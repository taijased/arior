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
