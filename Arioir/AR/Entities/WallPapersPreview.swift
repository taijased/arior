//
//  WallPapersPreview.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 22/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit

class WallPaperPreview: VirtualObject, UpdatableByPointer
{
    lazy var firstPointer = createPointer()
    lazy var secondPointer = createPointer()
    lazy var wallHeight: CGFloat = wallSigmentConfigs.initialHeight
    
    var wallSigment: WallSigment!
    let wallSigmentConfigs = WallSigmentConfigs()
    
    
    init(sceneView: ARSCNView, planeDetector: PlaneDetector, image: UIImage, textureLength: Float, textureWidth: Float)
    {
        let node = SCNNode()
        node.position = SCNVector3Zero
        
        super.init(geometryComponent: GKSCNNodeComponent(node: node), sceneView: sceneView, planeDetector: planeDetector)
        
        firstPointer.node.position = SCNVector3(-0.5, 0, 0)
        secondPointer.node.position = SCNVector3(0.5, 0, 0)
        
        firstPointer.updatable = self
        secondPointer.updatable = self
        
        node.addChildNode(firstPointer.node)
        node.addChildNode(secondPointer.node)
        
        let pos = firstPointer.node.position
        let previousPos = secondPointer.node.position
        let position = SCNVector3(0, wallHeight * 0.5, 0)
        let direction = pos - previousPos
        let eulerAngles = SCNVector3(x: 0, y: atan2f(direction.x, direction.z) + .pi * 0.5, z: 0)
        
        wallSigment = createWallSigment(position: position, eulerAngles: eulerAngles, width: wallHeight)
        wallSigment.textureSigment(textureLength: textureLength, textureWidth: textureWidth, textureImage: image)
        node.addChildNode(wallSigment.node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createPointer() -> WallPaperPreviewPointer
    {
        let ringGeometry = SCNTube(innerRadius: 0.05, outerRadius: 0.06, height: 0.002)
        ringGeometry.firstMaterial?.diffuse.contents = UIColor.white
        let stickGeometry = SCNCylinder(radius: 0.005, height: 1)
        stickGeometry.firstMaterial?.diffuse.contents = UIColor.init(hexValue: "#FFBF00", alpha: 1)
        
        let node = SCNNode()
        
        node.name = "pointer"
        
        let ringNode = SCNNode(geometry: ringGeometry)
        ringNode.name = "tube"
        let stickNode = SCNNode(geometry: stickGeometry)
        stickNode.name = "stick"
        stickNode.position = SCNVector3(0, 0.5, 0)
        
        node.addChildNode(ringNode)
        node.addChildNode(stickNode)
        
        let geometryComponent = GKSCNNodeComponent(node: node)
        let pointer = WallPaperPreviewPointer(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: planeDetector)
        return pointer
    }
    
    func createWallSigment(position: SCNVector3, eulerAngles: SCNVector3, width: CGFloat) -> WallSigment
    {
        let plane = SCNPlane(width: width, height: wallHeight)
        plane.firstMaterial?.isDoubleSided = true
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles = eulerAngles
        let geometryComponent = GKSCNNodeComponent(node: node)
        let wallSigment = WallSigment(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: planeDetector)
        wallSigment.delegate = self
        return wallSigment
    }
    
    func updateWallSigment(firstPointer: VirtualObject, secondPointer: VirtualObject)
    {
        
        let startPos = firstPointer.node.position
        let endPos = secondPointer.node.position
        
        let length = norm(startPos - endPos)
        self.wallSigment.node.position = (startPos + endPos) * 0.5 + SCNVector3(0, wallHeight * 0.5, 0)
        let ea = wallSigment.node.eulerAngles
        self.wallSigment.node.eulerAngles = SCNVector3Make(ea.x, acos((endPos.z - startPos.z) / length) + .pi * 0.5, ea.z)
        self.wallSigment.plane.width = CGFloat(length)
        self.wallSigment.textureSigment(textureLength: self.wallSigment.textureLength, textureWidth: self.wallSigment.textureWidth, textureImage: self.wallSigment.plane.firstMaterial?.diffuse.contents)
    }
    
    func update()
    {
     
        updateWallSigment(firstPointer: firstPointer, secondPointer: secondPointer)
        
    }
    
}

extension WallPaperPreview: VirtualObjectInteractionProtocol
{
    func onRotate(gesture: UIRotationGestureRecognizer, sceneView: ARSCNView) {
        
    }
    
    func onPan(gesture: UIPanGestureRecognizer, sceneView: ARSCNView) {
        let offset = -0.00004 * gesture.velocity(in: sceneView).y
        let offsetVector = SCNVector3(0, offset, 0)
        let halfOffsetVector = offsetVector * 0.5
        
        if((wallHeight + offset) < 0.1)
        {
            return
        }
        
        wallHeight = wallHeight + offset
        
        DispatchQueue.main.async {
            
            
            self.wallSigment .plane.height = self.wallHeight
            self.wallSigment .node.position = self.wallSigment .node.position + halfOffsetVector
            self.wallSigment .textureSigment(textureLength: self.wallSigment.textureLength, textureWidth: self.wallSigment.textureWidth, textureImage: self.wallSigment .plane.firstMaterial?.diffuse.contents)
            
            
            
            self.firstPointer.stick.height = self.wallHeight
            self.firstPointer.stickNode?.position = ( self.firstPointer.stickNode?.position)! + halfOffsetVector
            self.secondPointer.stick.height = self.wallHeight
            self.secondPointer.stickNode?.position = ( self.secondPointer.stickNode?.position)! + halfOffsetVector
            
        }
    }
    
    func onPreparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor) {
        
    }
    
    func onPinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView) {
        
    }
    
    func onTap(gesture: UITapGestureRecognizer, sceneView: ARSCNView, virtualObject: VirtualObject)
    {
        
        
    }
}

