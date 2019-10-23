//
//  DirectingLinesProcessor.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 04/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit

class DirectingLinesProcessor: GKComponent
{
    let directingLineConfig = DirectingLineConfig()
    
    let pointersProcessor: PointersProcessor
    
    let sceneView: ARSCNView
    
    let wallBuilder: WallBuilder
    
    var activeLines = [DirectingLine]()
    
    var highlitedLine: SCNNode!
//    {
//        willSet
//        {
//            highlitedLine?.changeColor(color: directingLineConfig.defaultColor)
//        }
//        didSet
//        {
//             highlitedLine?.changeColor(color: directingLineConfig.colorWhenMagnited)
//        }
//    }
    
    init(sceneView: ARSCNView ,pointersProcessor: PointersProcessor, wallBuilder: WallBuilder)
    {
        self.wallBuilder = wallBuilder
        self.pointersProcessor = pointersProcessor
        self.sceneView = sceneView
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createDirectingLine(ultimate: SCNNode, penultimate: SCNNode, isFirst: Bool = false) -> DirectingLine
    {
        let node = directingLineConfig.createNode()
        let geometryComponent = GKSCNNodeComponent(node: node)
        sceneView.addToSceneView(node: node)

        let direction = ultimate.position - penultimate.position
        let length = norm(direction)
        if isFirst
        {
            node.eulerAngles = SCNVector3Make(0, acos(direction.z / length) + .pi * 0.5, atan2(direction.y, direction.x))
            node.position = penultimate.position
        }
        else
        {
            node.eulerAngles = SCNVector3Make(0, acos(direction.z / length) - .pi * 0.5, atan2(direction.y, direction.x))
            node.position = ultimate.position
        }
        
        let directingLine = DirectingLine(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: wallBuilder.planeDetector)

        return directingLine
    }
    
    func addDirectingLine()
    {
        guard let ultimate = pointersProcessor.activePointers.last?.geometryComponent.node,
            let penultimate = pointersProcessor.activePointers.dropLast().last?.geometryComponent.node else {return}
        
        if activeLines.isEmpty
        {
            let directingLine = createDirectingLine(ultimate: ultimate, penultimate: penultimate, isFirst: true)
            activeLines.append(directingLine)
        }
        
        let directingLine = createDirectingLine(ultimate: ultimate, penultimate: penultimate)
        activeLines.append(directingLine)
        
        
    }
    
    func onDone()
    {
        activeLines.forEach{
            $0.geometryComponent.node.removeFromParentNode()
        }
        activeLines = [DirectingLine]()
    }
    
    func undo()
    {
        activeLines.last?.geometryComponent.node.removeFromParentNode()
        activeLines = Array(activeLines.dropLast())
        if activeLines.count < 2
        {
            onDone()
        }
        
    }
    
    func onReset()
    {
        activeLines.forEach{
            $0.geometryComponent.node.removeFromParentNode()
        }
        activeLines = [DirectingLine]()
    }
    
}
