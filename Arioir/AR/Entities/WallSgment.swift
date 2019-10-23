//
//  WallSgment.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 02/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit
class WallSigment: VirtualObject
{
    var areaLabel: UILabel!
    
    lazy var plane = node.geometry as! SCNPlane
    
    var textureLength: Float = 1
    
    var textureWidth: Float = 1
    
    func updateLabel()
    {
        guard let label = areaLabel, let cameraPosition = sceneView.pointOfView?.position else {return}
        let screenCoordinates = sceneView.projectPoint(node.worldPosition)
        
        let results = sceneView.scene.rootNode.hitTestWithSegment(from: cameraPosition, to: node.position, options: nil)

        if !screenCoordinates.x.isNaN && screenCoordinates.z < 1
        {
            let area = plane.height * plane.width
            label.text = String(format: "%.2f", area) + " кв. м"
            label.center = CGPoint(x: CGFloat(screenCoordinates.x), y: CGFloat(screenCoordinates.y))
            label.isHidden = false
        }
        else
        {
            label.isHidden = true
        }
        
        if !results.isEmpty
        {
            for result in results
            {
                if result.node != node
                {
                    label.isHidden = true
                    return
                }
            }
        }
        
    }
    
    func onReset()
    {
        areaLabel?.removeFromSuperview()
        areaLabel = nil
    }
    
    func textureSigment(textureLength: Float, textureWidth: Float, textureImage: Any!)
    {
        
        let texture = textureImage ?? UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        self.textureWidth = textureWidth
        self.textureLength = textureLength
        
        let lengthCount = Float(self.plane.height) / textureLength
        let widthCount = Float(self.plane.width) / textureWidth
        
        plane.firstMaterial?.diffuse.contents = texture
        plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(widthCount, lengthCount, 0)
        plane.firstMaterial?.diffuse.wrapS = .repeat
        plane.firstMaterial?.diffuse.wrapT = .repeat
    }
    
    var isHightLighted = false
    
    func addGlowing(color: UIColor)
    {
        isHightLighted = true
        node.addGlow(sceneView: sceneView)
        node.changeColor(color: color)
    }
    
    func removeGlowing(color: UIColor)
    {
        isHightLighted = false
        node.removeGlow(sceneView: sceneView)
        node.changeColor(color: color)
    }
    
    func changeGlowingState(color: UIColor)
    {
        if isHightLighted
        {
            removeGlowing(color: color)
        }
        else
        {
            addGlowing(color: color)
        }
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        DispatchQueue.main.async {
            self.updateLabel()
        }
    }
    
    
}

