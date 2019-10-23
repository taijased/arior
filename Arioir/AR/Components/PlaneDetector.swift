//
//  PlaneDetector.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 27/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

enum CategoryBitMask: Int
{
    case floor = 2
}

class PlaneDetector
{
    
    let sceneView: ARSCNView
    
    var isPlaneDetected : Bool = false
    var planeAnchor : ARPlaneAnchor!

    init(sceneView: ARSCNView)
    {
        self.sceneView = sceneView
    }
    
    var planeAnchorY:Float!
    {
        guard let anchor = planeAnchor else {return nil}
        return anchor.transform.columns.3.y
    }
    func detectPlane(anchor: ARAnchor) -> Bool
    {
        if isPlaneDetected {return false}
        guard anchor is ARPlaneAnchor else {return false}
        planeAnchor = (anchor as! ARPlaneAnchor)
        isPlaneDetected = true
        
        return true
    }
    
    func updatePlaneAnchor()
    {
        isPlaneDetected = false
        planeAnchor = nil
    }
    
}
