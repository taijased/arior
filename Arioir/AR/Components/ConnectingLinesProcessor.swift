//
//  DerectingLineProcessor.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 01/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import GameplayKit
import ARKit

class ConnectingLinesProcessor: GKComponent
{
    let sceneView: ARSCNView
    
    var wallBuilder: WallBuilder
    
    var pointersProcessor: PointersProcessor
    
    let connectingLineConfigs = ConnectingLineConfigs()
    
    var currentLine:ConnectingLine!
    var activeLines = [ConnectingLine]()
    var linesInWall = [ConnectingLine]()
    
    init(pointersProcessor: PointersProcessor, sceneView: ARSCNView, wallBuilder: WallBuilder)
    {
        self.sceneView = sceneView
        self.wallBuilder = wallBuilder
        self.pointersProcessor = pointersProcessor
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addConnectingLine()
    {
        if pointersProcessor.activePointers.isEmpty
        {
            return
        }
        if currentLine != nil
        {
            currentLine.isCurrent = false
            activeLines.append(currentLine)
        }
        currentLine = createConnectingLine()
        currentLine.isCurrent = true
        currentLine.lengthLabel = createLengthLabel()
    }
    
    func createLengthLabel() -> UILabel
    {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 25)))
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.text = ""
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.font = label.font.withSize(10)
        label.isHidden = true
        sceneView.addSubview(label)
        return label
    }
    
    private func createConnectingLine() -> ConnectingLine
    {
        let node = SCNNode(geometry: SCNCylinder(radius: connectingLineConfigs.radius, height: 1))
        node.geometry?.firstMaterial?.diffuse.contents = connectingLineConfigs.color
        let geometryComponent = GKSCNNodeComponent(node: node)
        let connectionLine = ConnectingLine(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: wallBuilder.planeDetector)
        
        
        guard
            let startPos = self.pointersProcessor.activePointers.last?.geometryComponent.node.position,
            let endPos = self.pointersProcessor.currentPointer?.geometryComponent.node.position
            else
        {
            sceneView.addToSceneView(node: node)
            return connectionLine
            
        }
        connectionLine.updatePosition(startPos: startPos, endPos: endPos)
        sceneView.addToSceneView(node: node)
        return connectionLine
    }
    
    func onDone()
    {
        currentLine?.geometryComponent.node.removeFromParentNode()
        currentLine?.onRemove()
        currentLine = nil
        activeLines.forEach{
            $0.geometryComponent.node.isHidden = true
        }
        
        linesInWall.append(contentsOf: activeLines)
        activeLines = [ConnectingLine]()
        
    }
    
    func undo()
    {
        activeLines.last?.onRemove()
        activeLines.last?.geometryComponent.node.removeFromParentNode()
        activeLines = Array(activeLines.dropLast())
        
        if pointersProcessor.activePointers.isEmpty
        {
            currentLine?.geometryComponent.node.removeFromParentNode()
            currentLine?.onRemove()
            currentLine = nil
        }
        
    }
    
    func onReset()
    {
        currentLine?.node.removeFromParentNode()
        currentLine?.onRemove()
        currentLine = nil
        activeLines.forEach{
            $0.geometryComponent.node.removeFromParentNode()
            $0.onRemove()
        }
        activeLines = [ConnectingLine]()
        
        linesInWall.forEach{
            $0.node.removeFromParentNode()
            $0.onRemove()
        }
        
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        for line in activeLines
        {
            line.update(deltaTime: seconds)
        }
        
        for line in linesInWall
        {
            line.update(deltaTime: seconds)
        }
        
        currentLine?.update(deltaTime: seconds)
        
    }
}


