//
//  ARPreviewViewController.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 20/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import UIKit
import ARKit
import GameplayKit
class ARPreviewViewController: UIViewController
{
    
    let arView = ARPreviewViewModel(frame: CGRect.init())
    lazy var arFacade = ARPreviewFacade(viewModel: arView)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(arView)
        arView.fillSuperview()
        arView.delegate = self
        arFacade.runARSession()
        let userCoaching = UserCoaching(coachingLabel: arView.coachingLabel, arFacade: arFacade)
        userCoaching.delegate = arFacade
        arFacade.delegate = userCoaching

    }
}



//MARK: - ARPreviewModelProtocol

extension ARPreviewViewController: ARPreviewModelProtocol {
    
    func close() {
        self.dismiss(animated: true , completion: nil)
    }

    func restart() {
        arFacade.resetTracking()
    }
}


