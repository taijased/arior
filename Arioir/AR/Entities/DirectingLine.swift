//
//  DirectingLine.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 04/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit

class DirectingLine: VirtualObject
{
    
    var equations: [SCNNode : LineParametricEquation]!
    
    override init(geometryComponent: GKSCNNodeComponent, sceneView: ARSCNView, planeDetector: PlaneDetector)
    {
        let node = geometryComponent.node
        let parallel = LineParametricEquation(startPoint: node.worldPosition, directionVector: node.worldRight, type: .parallel)
        let perpendicular = LineParametricEquation(startPoint: node.worldPosition, directionVector: -1 * node.worldFront, type: .perpendicular)
        equations = [
            geometryComponent.node.childNodes.first!: parallel,
            geometryComponent.node.childNodes.last!: perpendicular
        ]
        super.init(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: planeDetector)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
