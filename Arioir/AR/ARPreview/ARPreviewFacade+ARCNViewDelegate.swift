//
//  ARPreviewFacade+ARCNViewDelegate.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 22/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

extension ARPreviewFacade: ARSCNViewDelegate
{
    //    MARK: - SCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
    {
        Time.shared.updateTime(time: time)
        previewEntitie?.update(deltaTime: time)
    }
    
    //    MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if planeDetector.detectPlane(anchor: anchor)
        {
            delegate?.onPlaneDetected()
        }
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
}


