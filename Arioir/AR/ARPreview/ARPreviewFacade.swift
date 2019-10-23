//
//  ARPreviewFacade.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 22/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
class ARPreviewFacade:NSObject, ARFacadeProtocol, OnPlaneDetectedProtocol
{
    let viewModel: ARPreviewViewModel
    
    let sceneView: ARSCNView
    
    let planeDetector: PlaneDetector
    
    let interactions: ARInteractions
    
    var delegate: ARSessionStateProtocot!
    
    var previewEntitie: VirtualObject!
    
    init(viewModel: ARPreviewViewModel)
    {
        self.viewModel = viewModel
        self.sceneView = viewModel.sceneView
        self.planeDetector = PlaneDetector(sceneView: sceneView)
        self.interactions = ARInteractions(sceneView: sceneView, planeDetector: planeDetector)
        super.init()
        sceneView.delegate = self
        sceneView.session.delegate = self
    }
    
    func runARSession(planeDetection: ARWorldTrackingConfiguration.PlaneDetection = [.horizontal], autoenableDefaultLighting : Bool = true)
    {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = planeDetection
        sceneView.showsStatistics = true
        sceneView.session.run(configuration, options: .resetTracking)
        sceneView.autoenablesDefaultLighting = autoenableDefaultLighting
        
    }
    
    func resetTracking()
    {
        runARSession()

    }
    

    
    func isPlaneDetected() -> Bool {
        return planeDetector.isPlaneDetected
    }
    
    
    
    func onPlaneDetected()
    {
        DispatchQueue.main.async {
            let results = self.sceneView.session.currentFrame?.hitTest(CGPoint(x: 0.5, y: 0.5), types: ARHitTestResult.ResultType.existingPlane)
            guard let res = results else {return}
            for result in res
            {
                if result.anchor == self.planeDetector.planeAnchor
                {
                    let pos = result.worldTransform.columns.3.toSCNVector3()
                    guard let entitie = self.previewEntitie else {return}
                    self.sceneView.addToSceneView(node: entitie.node)
                    entitie.node.position = SCNVector3(pos.x, self.planeDetector.planeAnchorY!, pos.z)
                    return
                }
            }
            
        }
    }
    
 
}
