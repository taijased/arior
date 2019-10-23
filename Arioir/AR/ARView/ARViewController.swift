//
//  ViewController.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 18/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import UIKit
import ARKit
import GameplayKit
class ARViewController: UIViewController {
    
    let arView = ARViewModel(frame: CGRect.init())
    lazy var arFacade = ARFacade(viewModel: arView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(arView)
        arView.fillSuperview()
        arFacade.runARSession()
        arFacade.delegate = UserCoaching(coachingLabel: arView.coachingLabel, arFacade: arFacade)
        arView.delegate = self
        
        
        arView.textureWalls.addTarget(self, action: #selector(addTexture(_:)), for: .touchUpInside)
        arView.hideAreaLabels.addTarget(self, action: #selector(hideAreaLabels(_:)), for: .touchUpInside)
        arView.preview.addTarget(self, action: #selector(changeViewController(_:)), for: .touchUpInside)
    }
    
    @objc func addTexture(_ sender: Any)
    {
        print(#function)
        arFacade.textureWalls()
        
    }
    
    @objc func hideAreaLabels(_ sender: Any)
    {
        print(#function)
        arFacade.hideAreaLabels()
    }
    
    @objc func changeViewController(_ sender: Any)
    {
        print(#function)
        let previewViewController = ARPreviewViewController()
        let path = "ScnAssets.scnassets/beer2.jpg"
        let image = UIImage(named: path)
        let vo = WallPaperPreview(sceneView: previewViewController.arView.sceneView, planeDetector: previewViewController.arFacade.planeDetector, image: image!, textureLength: 1.2, textureWidth: 0.8)
        previewViewController.arFacade.previewEntitie = vo
        present(previewViewController , animated: true, completion: nil)
        for view in view.subviews
        {
            view.removeFromSuperview()
        }
    }
}



