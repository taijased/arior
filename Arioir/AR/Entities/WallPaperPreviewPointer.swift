//
//  WallPaperPreviewPointer.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 22/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit

protocol UpdatableByPointer: class
{
    func update()
}

class WallPaperPreviewPointer: Pointer
{
    
    var updatable: UpdatableByPointer!
    
    override func customPan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView)
    {
        DispatchQueue.main.async {
            let results = self.sceneView.hitTest(gesture.location(in: sceneView), types: ARHitTestResult.ResultType.existingPlane)
            for result in results
            {
                if result.anchor == self.planeDetector.planeAnchor
                {
                    let pos = result.worldTransform.columns.3.toSCNVector3()
                    let position = SCNVector3(pos.x, self.planeDetector.planeAnchorY!, pos.z)
                    self.node.worldPosition = position
                    self.updatable?.update()
                    return
                }
            }
        }
    }
}
