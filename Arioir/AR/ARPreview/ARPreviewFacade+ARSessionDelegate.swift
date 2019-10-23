//
//  ARPreviewFacade+ARSessionDelegate.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 22/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//
import ARKit
extension ARPreviewFacade: ARSessionDelegate
{
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
        
    }
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
    }
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        
    }
    
    // MARK: - ARSessionObserver
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        delegate?.onSessionIneraptionEnded(session)
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        delegate?.onSessionDidFaledWith(error: error)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState
        {
        case .normal:
            delegate?.onStateChangedToNormal()
            
        case .notAvailable:
            delegate?.onStateChangedToNotAvalible()
            
        case .limited(let reason):
            delegate?.onStateChangedToLimited(reason)
            
        }
    }
}

