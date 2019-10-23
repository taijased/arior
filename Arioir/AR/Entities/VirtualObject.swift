//
//  VirtualObject.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 28/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class VirtualObject: GKEntity
{
    var geometryComponent: GKSCNNodeComponent

    let sceneView: ARSCNView

    let planeDetector: PlaneDetector
    
    lazy var node: SCNNode = geometryComponent.node
    
    var delegate: VirtualObjectInteractionProtocol!
    
    init(geometryComponent: GKSCNNodeComponent, sceneView: ARSCNView, planeDetector: PlaneDetector)
    {
        self.sceneView = sceneView
        self.geometryComponent = geometryComponent
        self.planeDetector = planeDetector
        super.init()
        addComponent(geometryComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePosition(position: SCNVector3!)
    {
        guard let pos = position else {return}
           node.position = pos
    }
    
    func updateEulerAngles(eulerAngles: SCNVector3)
    {
        DispatchQueue.main.async {
            self.geometryComponent.node.eulerAngles = eulerAngles
        }
    }
    
    func updateTeransform(transform: simd_float4x4)
    {
        DispatchQueue.main.async {
            self.geometryComponent.node.simdTransform = transform
        }
    }
    
    func updateTransform(transform: SCNMatrix4)
    {
        DispatchQueue.main.async {
            self.geometryComponent.node.transform = transform
        }
    }
    
    func customInteractingNode(gesture: UIGestureRecognizer)
    {
        
    }
    
    func customRotate(gesture: UIRotationGestureRecognizer, sceneView: ARSCNView)
    {
        
    }
    
    func customPan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView)
    {
        
    }
    
    func customPreparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor)
    {
        
    }
    
    func customPinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView)
    {
        
    }
    
    func customTap(gesture: UITapGestureRecognizer, sceneView: ARSCNView)
    {
        
    }
    
}

extension VirtualObject: ARInteractionsProtocol
{
    func interactingNode(gesture: UIGestureRecognizer) -> ARInteractionsProtocol!
    {
        customInteractingNode(gesture: gesture)
        return self
    }
    
    func rotate(gesture: UIRotationGestureRecognizer, sceneView: ARSCNView)
    {
        customRotate(gesture: gesture, sceneView:  sceneView)
        delegate?.onRotate(gesture: gesture, sceneView: sceneView)
    }
    
    func pan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView)
    {
        customPan(gesture: gesture, sceneView: sceneView)
        delegate?.onPan(gesture: gesture, sceneView: sceneView)
    }
    
    func preparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor)
    {
        customPreparation(gesture: gesture, sceneView: sceneView, planeAnchor: planeAnchor)
        delegate?.onPreparation(gesture: gesture, sceneView: sceneView, planeAnchor: planeAnchor)
    }
    
    func pinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView)
    {
        customPinch(gesture: gesture, sceneView: sceneView)
        delegate?.onPinch(gesture: gesture, sceneView: sceneView)
    }
    
    func tap(gesture: UITapGestureRecognizer, sceneView: ARSCNView)
    {
        customTap(gesture: gesture, sceneView: sceneView)
        delegate?.onTap(gesture: gesture, sceneView: sceneView, virtualObject: self)
    }
  
}

