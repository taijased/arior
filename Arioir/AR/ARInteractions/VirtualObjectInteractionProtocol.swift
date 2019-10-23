//
//  VirtualObjectInteractionProtocol.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 17/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

protocol VirtualObjectInteractionProtocol
{
    func onRotate(gesture: UIRotationGestureRecognizer, sceneView: ARSCNView)
    
    func onPan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView)
    
    func onPreparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor)
    
    func onPinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView)
    
    func onTap(gesture: UITapGestureRecognizer, sceneView: ARSCNView, virtualObject: VirtualObject)
}
