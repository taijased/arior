//
//  WallBuilder.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 28/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class WallBuilder: GKEntity
{
    let sceneView: ARSCNView
    
    let raycaster: Raycaster
    
    let planeDetector: PlaneDetector
    
    lazy var pointersProcessor = PointersProcessor(wallBuilder: self, sceneView: sceneView)
    
    lazy var directingLineProcessor = DirectingLinesProcessor(sceneView: sceneView, pointersProcessor: pointersProcessor, wallBuilder: self)
    
    lazy var connectingLinesProcessor = ConnectingLinesProcessor(pointersProcessor: pointersProcessor, sceneView: sceneView, wallBuilder: self)
    
    lazy var wallHeight: CGFloat = wallSigmentConfigs.initialHeight;
    
    var wallSigments = [WallSigment]()
    
    var hightLightedWallSigments = [WallSigment]()
    
    var pointersInWall = [Pointer]()
    
    let wallSigmentConfigs = WallSigmentConfigs()
    
    let magnitizingRadius: Float = 0.15
    
    let maxAnimationDuration: Double = 0.075
    
    var delegate: ViewModelUpdateProtocol!
    
    init(sceneView: ARSCNView, planeDetector: PlaneDetector)
    {
        self.sceneView = sceneView
        self.raycaster = Raycaster(sceneView: sceneView, planeDetector: planeDetector)
        self.planeDetector = planeDetector
        super.init()
        addComponent(raycaster)
        addComponent(pointersProcessor)
        addComponent(connectingLinesProcessor)
        addComponent(directingLineProcessor)
        sceneView.addToSceneView(node: intermidiatePointer)
    }
    
    func addPointer()
    {
        if !raycaster.planeDetector.isPlaneDetected {return}
        pointersProcessor.addPointer()
        connectingLinesProcessor.addConnectingLine()
        directingLineProcessor.addDirectingLine()
    }
    
    func undo()
    {
        pointersProcessor.undo()
        connectingLinesProcessor.undo()
        directingLineProcessor.undo()
    }
    
    func reset()
    {
        pointersProcessor.onReset()
        connectingLinesProcessor.onReset()
        directingLineProcessor.onReset()
        wallSigments.forEach{
            $0.onReset()
            $0.geometryComponent.node.removeFromParentNode()
        }
        wallSigments = [WallSigment]()
        
        pointersInWall.forEach{
            $0.geometryComponent.node.removeFromParentNode()
        }
        
        delegate?.deactivateHeightLabel()
        
    }
    
    func createAreaLabel() -> UILabel
    {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 70, height: 40)))
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.text = ""
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.font = label.font.withSize(15)
        label.isHidden = true
        sceneView.addSubview(label)
        return label
    }
    
    func buildWall()
    {
        var previousPointer = pointersProcessor.activePointers.first
        var newWallSigments = [WallSigment]()

        for pointer in pointersProcessor.activePointers.dropFirst()
        {
            guard let previousPos = previousPointer?.geometryComponent.node.position else {return}
            let pos = pointer.geometryComponent.node.position
            let position = (previousPos + pos) * 0.5 + SCNVector3(0, wallHeight * 0.5, 0)
            let direction = pos - previousPos
            let eulerAngles = SCNVector3(x: 0, y: atan2f(direction.x, direction.z) + .pi * 0.5, z: 0)
            let sigment = createWallSigment(position: position, eulerAngles: eulerAngles, width:CGFloat(norm(direction)))
            sigment.areaLabel = createAreaLabel()
            newWallSigments.append(sigment)

            previousPointer = pointer
   
        }
        
        wallSigments.append(contentsOf: newWallSigments)
        
        delegate?.updateHeightLabel(height: wallHeight)
        delegate?.activateHeightLabel()
        
        pointersProcessor.onDone()
        connectingLinesProcessor.onDone()
        directingLineProcessor.onDone()
    }
    
    func createWallSigment(position: SCNVector3, eulerAngles: SCNVector3, width: CGFloat) -> WallSigment
    {
        let plane = SCNPlane(width: width, height: wallHeight)
        plane.firstMaterial?.isDoubleSided = true
        let node = SCNNode(geometry: plane)
        node.position = position
        node.eulerAngles = eulerAngles
        sceneView.addToSceneView(node: node)
        let geometryComponent = GKSCNNodeComponent(node: node)
        let wallSigment = WallSigment(geometryComponent: geometryComponent, sceneView: sceneView, planeDetector: planeDetector)
        wallSigment.delegate = self
        return wallSigment
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nearestLines() -> [(key: SCNNode, value: LineParametricEquation, point: SCNVector3)?]!
    {
        var lines:[(key: SCNNode, value: LineParametricEquation, point: SCNVector3)?]!
        guard let pointerPos = raycaster.position else {return lines}
        var distance = Float.infinity
        
        var firstLine: (key: SCNNode, value: LineParametricEquation, point: SCNVector3)!
        var secondLine: (key: SCNNode, value: LineParametricEquation, point: SCNVector3)!
        
        for line in directingLineProcessor.activeLines
        {
            for equation in line.equations
            {
                let nearestPoint:(SCNVector3, Float) = equation.value.nearestPointOnLine(to: pointerPos)
                let tempDist = norm(nearestPoint.0 - pointerPos)
                if tempDist > magnitizingRadius || (nearestPoint.1 < 0 && equation.value.type == .parallel) {continue}
                
                if tempDist <= distance
                {
                    distance = tempDist
                    secondLine = firstLine
                    firstLine = (key: equation.key, value: equation.value, point: nearestPoint.0)
                }
            }
        }
        if firstLine != nil
        {
            lines = [(key: SCNNode, value: LineParametricEquation, point: SCNVector3)?]()
            lines.append(firstLine)
        }
        if secondLine != nil
        {
            if lines == nil
            {
                lines = [(key: SCNNode, value: LineParametricEquation, point: SCNVector3)?]()
            }
            lines.append(secondLine)
        }
        return lines
    }
    
    func pointerLinesPosition(nearestLines: [(key: SCNNode, value: LineParametricEquation, point: SCNVector3)?]!) -> SCNVector3!
    {
        guard let lines = nearestLines else {
            directingLineProcessor.highlitedLine?.changeColor(color: directingLineProcessor.directingLineConfig.defaultColor)
            directingLineProcessor.highlitedLine = nil
            return nil}
        
        if lines.count == 2
        {
            let intersectionPoint = lines.first??.value.intersectionPointWithLine(equation: (lines.last??.value))
            guard let point = intersectionPoint else {return (lines.first??.point)!}
            return point
        }
        else
        {
            directingLineProcessor.highlitedLine = lines.first??.key
            return (lines.first??.point)!
        }
    }

    func pointerScenePosition() -> SCNVector3
    {
        let nearestLines = self.nearestLines()
        guard
            let pointerLinesPosition = self.pointerLinesPosition(nearestLines: nearestLines)
            else
        {
            
            return raycaster.position
        }
        
        return pointerLinesPosition
    }
    
    
    func updatePointer()
    {
        guard let pointerPos = pointersProcessor.currentPointer?.geometryComponent.node.position else {
            return
        }
        
        let position = (intermidiatePointer.position - pointerPos) * Float(Time.shared.deltaTime) * 10 +  pointersProcessor.currentPointer.geometryComponent.node.position
        pointersProcessor.currentPointer?.updatePosition(position:   position)
    }
    
    func updateIntermidiatePointer()
    {
        if raycaster.position == nil {return}
        intermidiatePointer.position = pointerScenePosition()
    }
    
    let intermidiatePointer = SCNNode()
    
    override func update(deltaTime seconds: TimeInterval)
    {
        super.update(deltaTime: seconds)
        
        DispatchQueue.main.async {
            
            for sigment in self.wallSigments
            {
                sigment.update(deltaTime: seconds)
            }
            self.updateIntermidiatePointer()
            self.updatePointer()
            guard
                let startPos = self.pointersProcessor.activePointers.last?.geometryComponent.node.position,
                let endPos = self.pointersProcessor.currentPointer?.geometryComponent.node.position
                else {return}
            self.connectingLinesProcessor.currentLine?.updatePosition(startPos: startPos, endPos: endPos)
        }
    }
}

extension WallBuilder: VirtualObjectInteractionProtocol
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
        delegate?.updateHeightLabel(height: wallHeight)
        DispatchQueue.main.async {
            
            for sigment in self.wallSigments
            {
                sigment.plane.height = self.wallHeight
                sigment.node.position = sigment.node.position + halfOffsetVector
                sigment.textureSigment(textureLength: sigment.textureLength, textureWidth: sigment.textureWidth, textureImage: sigment.plane.firstMaterial?.diffuse.contents)
            }
            
            for pointer in self.pointersInWall
            {
                pointer.stick.height = self.wallHeight
                pointer.stickNode?.position = (pointer.stickNode?.position)! + halfOffsetVector
            } 
        }
    }
    
    func onPreparation(gesture: UIGestureRecognizer, sceneView: ARSCNView, planeAnchor: ARPlaneAnchor) {
        
    }
    
    func onPinch(gesture: UIPinchGestureRecognizer, sceneView: ARSCNView) {
        
    }
    
    func onTap(gesture: UITapGestureRecognizer, sceneView: ARSCNView, virtualObject: VirtualObject)
    {
        if virtualObject is WallSigment
        {
            let segment = virtualObject as! WallSigment
            if segment.isHightLighted
            {
                hightLightedWallSigments.removeAll(where: {$0 == segment})
                segment.changeGlowingState(color: wallSigmentConfigs.color)
            }
            else
            {
                segment.changeGlowingState(color: wallSigmentConfigs.hightLightColor)
                hightLightedWallSigments.append(segment)
            }
        }
        
    }
    
    func testureSegments(textureLength: Float, textureWidth: Float, textureImage: Any!)
    {
        for segment in hightLightedWallSigments
        {
            segment.removeGlowing(color: wallSigmentConfigs.color)
            segment.textureSigment(textureLength: textureLength, textureWidth: textureWidth, textureImage: textureImage)
            
        }
    }
    
    
}
