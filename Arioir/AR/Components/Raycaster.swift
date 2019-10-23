//
//  Raycaster.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 27/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class Raycaster: GKComponent
{
    let sceneView:ARSCNView
    let planeDetector: PlaneDetector
    
    var position: SCNVector3!
    
    var previousPositions = [SCNVector3]()
    
    init(sceneView: ARSCNView, planeDetector: PlaneDetector)
    {
        self.sceneView = sceneView
        self.planeDetector = planeDetector
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        DispatchQueue.main.async {
            let results = self.sceneView.session.currentFrame?.hitTest(CGPoint(x: 0.5, y: 0.5), types: ARHitTestResult.ResultType.existingPlane)
            guard let res = results else {return}
            for result in res
            {
                if result.anchor == self.planeDetector.planeAnchor
                {
                    let pos = result.worldTransform.columns.3.toSCNVector3()
                    self.position = SCNVector3(x: pos.x, y: self.planeDetector.planeAnchorY, z: pos.z)
                }
            }
            
        }
        
    }

}
