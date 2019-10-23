//
//  SCNNode+glowing.swift
//  ARI-AR
//
//  Created by Alexey Antipin on 17/08/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//
import ARKit

extension SCNNode
{
    public func addGlow(sceneView:ARSCNView)
    {
        self.categoryBitMask = 2
        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path)  {
                let dict2 = dict as! [String : AnyObject]
                let technique = SCNTechnique(dictionary:dict2)
                sceneView.technique = technique
            }
        }
    }
    public func removeGlow(sceneView:ARSCNView)
    {
        self.categoryBitMask = 1
        sceneView.technique = nil
    }
}
