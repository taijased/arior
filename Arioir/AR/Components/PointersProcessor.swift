//
//  PointersProcessor.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 01/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit
class PointersProcessor: GKComponent
{
    
    let sceneView: ARSCNView
//    let pointerNode:SCNNode
    
    var wallBuilder: WallBuilder
    
    var currentPointer: Pointer!
    var activePointers = [Pointer]()
    
    var pointersInWall = [Pointer]()
    
    init(wallBuilder: WallBuilder, sceneView: ARSCNView)
    {
        self.wallBuilder = wallBuilder
        self.sceneView = sceneView
//        self.pointerNode = (SCNScene(named: "ScnAssets.scnassets/pointer.scn")?.rootNode.childNode(withName: "pointer", recursively: false))!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPointer()
    {
        if currentPointer != nil
        {
            activePointers.append(currentPointer)
        }
        currentPointer = createPointer()
    }
    
    private func createPointer() -> Pointer
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
        
        node.position = wallBuilder.raycaster.position
        let geometryComponent = GKSCNNodeComponent(node: node)
        let pointer = Pointer(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: wallBuilder.planeDetector)
        sceneView.addToSceneView(node: node)
        return pointer
    }
    
    
    func onDone()
    {
        
        currentPointer?.geometryComponent.node.removeFromParentNode()
        pointersInWall.append(contentsOf: activePointers)
        wallBuilder.pointersInWall.append(contentsOf: activePointers)
        activePointers.forEach{
            $0.geometryComponent.node.childNodes.forEach{
                    $0.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            }
            
            $0.stick.height = wallBuilder.wallHeight
            $0.stickNode?.position = SCNVector3(($0.stickNode?.position.x)!, Float(wallBuilder.wallHeight * 0.5), ($0.stickNode?.position.z)!)
            
        }
        activePointers = [Pointer]()
        currentPointer = nil
    }
    
    func undo()
    {
        activePointers.last?.geometryComponent.node.removeFromParentNode()
        activePointers = Array(activePointers.dropLast())
    }
    
    
    func onReset()
    {
        currentPointer?.node.removeFromParentNode()
        currentPointer = nil
        activePointers.forEach{
            $0.geometryComponent.node.removeFromParentNode()
        }
        activePointers = [Pointer]()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
        
        
        
    }
    
}
