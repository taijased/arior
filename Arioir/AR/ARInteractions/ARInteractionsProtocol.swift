//
//  ARInteractionsProtocol.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 17/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
protocol ARInteractionsProtocol
{
    func interactingNode(gesture: UIGestureRecognizer) -> ARInteractionsProtocol!
    
    func rotate(gesture: UIRotationGestureRecognizer, sceneView: ARSCNView)
    
    func pan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView)
    
    func preparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor)
    
    func pinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView)
    
    func tap(gesture: UITapGestureRecognizer, sceneView: ARSCNView)
}
