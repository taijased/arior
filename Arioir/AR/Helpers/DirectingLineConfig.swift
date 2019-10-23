//
//  DirectingLineConfig.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 04/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import SceneKit

struct DirectingLineConfig
{
    var colorWhenMagnited = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
    var defaultColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
    
    var node: SCNNode = {
        let node = SCNNode()
        
        let perpendicular = SCNNode()
        perpendicular.eulerAngles = SCNVector3(x: .pi * 0.5, y: 0, z: 0)
        perpendicular.position = SCNVector3Zero
        let parallel = SCNNode()
        parallel.eulerAngles = SCNVector3(x: .pi * 0.5, y: .pi * 0.5, z: 0)
        parallel.position = SCNVector3(x: 25, y: 0, z: 0)
        
        node.addChildNode(parallel)
        node.addChildNode(perpendicular)
        
        return node
    }()
    
    func createNode() ->SCNNode
    {
        let geometry = SCNPlane(width: 0.01, height: 50)
        geometry.firstMaterial?.diffuse.contents = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
        geometry.firstMaterial?.isDoubleSided = true
        
        let newNode = node.clone()
        newNode.childNodes.forEach
            {
                $0.geometry = geometry
        }
        return newNode
    }
    
}
