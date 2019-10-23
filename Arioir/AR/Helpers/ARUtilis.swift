//
//  ARUtilities.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 01/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

class ARUtils
{
    static func raycast(sceneView: ARSCNView, normalizedScreenCoord: CGPoint, types: ARHitTestResult.ResultType) ->SCNVector3!
    {
        let results = sceneView.session.currentFrame?.hitTest(normalizedScreenCoord, types: types)
        guard let pos = results?.first?.worldTransform.columns.3.toSCNVector3() else {return nil}
        return pos
    }
    
    static func raycast(sceneView: ARSCNView, screenCoords: CGPoint, types: ARHitTestResult.ResultType) ->SCNVector3!
    {
        let results = sceneView.hitTest(screenCoords, types: types)
        guard let pos = results.first?.worldTransform.columns.3.toSCNVector3() else {return nil}
        return pos
    }
  
}
