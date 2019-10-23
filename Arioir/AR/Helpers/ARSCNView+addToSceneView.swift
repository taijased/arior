//
//  ARSCNView+addToSceneView.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 02/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

extension SCNView
{
    func addToSceneView(node: SCNNode)
    {
        DispatchQueue.main.async {
            self.scene?.rootNode.addChildNode(node)
        }
    }
}
