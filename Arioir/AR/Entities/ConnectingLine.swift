//
//  ConnectionLine.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 29/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit

class ConnectingLine: VirtualObject
{
    
    var lengthLabel: UILabel!
    
    var isCurrent = false

    lazy var cylinder = node.geometry as! SCNCylinder
    
    func updateLabel()
    {
        guard let label = lengthLabel, let cameraPosition = sceneView.pointOfView?.position  else {return}
        let screenCoordinates = sceneView.projectPoint(node.worldPosition)
        if screenCoordinates.x.isNaN || screenCoordinates.z > 1 
        {
            label.isHidden = true
            return
        }
        
        let radius:Float = 100
        let length = cylinder.height
        var newPos: SCNVector3
        if isCurrent
        {
            let endPos = sceneView.projectPoint(self.endPos)
            let direction = screenCoordinates - endPos
            let distance = norm(direction)
            
            if distance < radius
            {
                newPos = screenCoordinates
            }
            else
            {
                newPos = direction / distance * radius + endPos
            }
            
            label.isHidden = false
        }
            
        else
        {
            let offset = SCNVector3(0, -0.01, 0)
            let results = sceneView.scene.rootNode.hitTestWithSegment(from: node.position + offset, to: cameraPosition, options: nil)
            
            newPos = screenCoordinates
            
            if !results.isEmpty
            {
                for result in results
                {
                    if result.node != node && !(result.node.parent?.entity is Pointer)
                    {
                        label.isHidden = true
                        return
                    }
                }
            }
            label.isHidden = false
        }
        label.text = String(format: "%.2f", length) + " м"
        label.center = CGPoint(x: CGFloat(newPos.x), y: CGFloat(newPos.y))
    }
    
    func updatePosition(startPos: SCNVector3, endPos: SCNVector3)
    {
        let length = norm(startPos - endPos)
        self.geometryComponent.node.position = (startPos + endPos) * 0.5
        self.geometryComponent.node.eulerAngles = SCNVector3Make(Float.pi * 0.5, acos((endPos.z - startPos.z) / length), atan2((endPos.y - startPos.y), (endPos.x - startPos.x)))
        (self.geometryComponent.node.geometry as! SCNCylinder).height = CGFloat(length)
        self.startPos = startPos
        self.endPos = endPos
    }
    
    var startPos = SCNVector3Zero
    var endPos = SCNVector3Zero
    
    override func update(deltaTime seconds: TimeInterval) {
        DispatchQueue.main.async {
            self.updateLabel()
        }
    }
    
    func onRemove()
    {
        lengthLabel?.removeFromSuperview()
        lengthLabel = nil
    }
    
}

