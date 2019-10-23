//
//  ARInteraction.swift
//  demo-uni
//
//  Created by Tim Zagirov on 08/03/2019.
//  Copyright © 2019 Tim Zagirov. All rights reserved.
//
import ARKit

class ARInteractions:NSObject, UIGestureRecognizerDelegate
{
    var sceneView: ARSCNView!
    
    var selectedObject: ARInteractionsProtocol?
    
    let planeDetector: PlaneDetector
    
    init(sceneView: ARSCNView, planeDetector: PlaneDetector)
    {
        
        self.sceneView = sceneView
        self.planeDetector = planeDetector
        super.init()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGesture.delegate = self
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        DispatchQueue.main.async {
            self.sceneView!.addGestureRecognizer(tapGesture)
            self.sceneView!.addGestureRecognizer(panRecognizer)
            self.sceneView!.addGestureRecognizer(rotationRecognizer)
            self.sceneView!.addGestureRecognizer(pinchRecognizer)
        }
        
    }
    
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer)
    {
        switch gesture.state {
        case .began:
            guard let interactingNode = interactingNode(gesture: gesture) else {return}
            selectedObject = interactingNode
        case .changed:
            selectedObject?.pinch(gesture: gesture, sceneView: sceneView)
        case .ended:
            fallthrough
        default:
            selectedObject = nil
        }
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer)
    {
        guard let interactingNode = interactingNode(gesture: gesture) else {return}
        //        interactingNode.preparation(gesture: gesture, sceneView: sceneView, planeAnchor: planeAnchor)
        interactingNode.tap(gesture: gesture, sceneView: sceneView)
    }
    
    @objc func didPan(_ gesture: UIPanGestureRecognizer)
    {
        switch gesture.state {
        case .began:
            guard let interactingNode = interactingNode(gesture: gesture) else {return}
            interactingNode.preparation(gesture: gesture, sceneView: sceneView, planeAnchor: planeDetector.planeAnchor)
            selectedObject = interactingNode
        case .changed:
            selectedObject?.pan(gesture: gesture, sceneView: sceneView)
        case .ended:
            fallthrough
        default:
            selectedObject = nil
        }
        
    }
    @objc func didRotate(_ gesture: UIRotationGestureRecognizer)
    {
        switch gesture.state {
        case .began:
            guard let interactingNode = interactingNode(gesture: gesture) else {return}
            interactingNode.preparation(gesture: gesture, sceneView: sceneView, planeAnchor: planeDetector.planeAnchor)
            selectedObject = interactingNode
        case .changed:
            selectedObject?.rotate(gesture: gesture, sceneView: sceneView)
        case .ended:
            fallthrough
        default:
            selectedObject = nil
        }
        
    }
    
    private func interactingNode(gesture: UIGestureRecognizer) -> ARInteractionsProtocol!
    {
        guard let nodeUnderTouch = objectInteracting(with: gesture, in: sceneView) else {return nil}
//        if nodeUnderTouch.entity is ARInteractionsProtocol
//        {
//            return (nodeUnderTouch.entity as! ARInteractionsProtocol)
//        }
//        return nil
        
        return findInteractingEntity(node: nodeUnderTouch)
        
    }
    
    private func objectInteracting(with gesture: UIGestureRecognizer, in view: ARSCNView) -> SCNNode! {
        for index in 0..<gesture.numberOfTouches {
            let touchLocation = gesture.location(ofTouch: index, in: view)
            if let object = view.nodeAt(point: touchLocation) {
                return object
            }
        }
        return sceneView?.nodeAt(point: gesture.center(in: view))
    }
    
    private func findInteractingEntity(node: SCNNode!) -> ARInteractionsProtocol!
    {
        guard let testNode = node else {return nil}
        if testNode.entity is ARInteractionsProtocol
        {
            return testNode.entity as? ARInteractionsProtocol
        }
        else
        {
            return findInteractingEntity(node: node?.parent)
        }
        
    }
    
}








