//
//  LengthLabels.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 11/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class LengthLabelsProcessor: GKComponent
{
    
    let sceneView: ARSCNView
    
    let connectingLineProcessor: ConnectingLinesProcessor
    
    var wallBuilder: WallBuilder
    
    var currentLabel: UILabel!
    
    var activeLabels = [UILabel]()
    
    var labelsInWall = [UILabel]()
    
    init(sceneView: ARSCNView, wallBuilder: WallBuilder, connectingLineProcessor: ConnectingLinesProcessor)
    {
        self.sceneView = sceneView
        self.wallBuilder = wallBuilder
        self.connectingLineProcessor = connectingLineProcessor
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return label
    }
    
    func addLengthLabel()
    {
        guard let line = connectingLineProcessor.currentLine else { return }
        
        if currentLabel != nil
        {
            activeLabels.append(currentLabel)
        }
        
        currentLabel = createLengthLabel()
        let screenCoordinates = sceneView.projectPoint(line.geometryComponent.node.worldPosition)
        currentLabel.text = String(format: "%.2f", Float((connectingLineProcessor.currentLine.node.geometry as! SCNCylinder).height)) + " м"
        currentLabel.center = CGPoint(x: CGFloat(screenCoordinates.x), y: CGFloat(screenCoordinates.y))
        sceneView.addSubview(currentLabel)
    }
    
    func updateCurrentLabel()
    {
        guard  let line = connectingLineProcessor.currentLine, let label = currentLabel else { return }
        
        let radius:Float = 100
        
        let pos = line.node.worldPosition
        let screenCoordinates = sceneView.projectPoint(pos)
        
        let endPos = sceneView.projectPoint(line.endPos)
        
     
        
        if !screenCoordinates.x.isNaN
        {
            
            var newPos: SCNVector3
            
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
            
            print(newPos)
            
            label.center = CGPoint(x: CGFloat(newPos.x), y: CGFloat(newPos.y))
            label.text = String(format: "%.2f", Float((line.node.geometry as! SCNCylinder).height)) + " м"
        }
        
    }

    func updateLabels(labels: [UILabel], lines: [ConnectingLine])
    {
        if labels.isEmpty || lines.isEmpty {return}
        for i in 0..<lines.count
        {
            let screenCoordinates = sceneView.projectPoint(lines[i].geometryComponent.node.worldPosition)
            if !screenCoordinates.x.isNaN
            {
                labels[i].text = String(format: "%.2f", Float((lines[i].geometryComponent.node.geometry as! SCNCylinder).height)) + " м"
                labels[i].center = CGPoint(x: CGFloat(screenCoordinates.x), y: CGFloat(screenCoordinates.y))
                labels[i].isHidden = false
            }
            else
            {
                labels[i].isHidden = true
            }
        }
    }
    
    func undo()
    {
        activeLabels.last?.removeFromSuperview()
        activeLabels = Array(activeLabels.dropLast())
        
        if wallBuilder.pointersProcessor.activePointers.isEmpty
        {
            currentLabel?.removeFromSuperview()
            currentLabel = nil
        }
        
    }
    
    func onReset()
    {
        activeLabels.forEach{
            $0.removeFromSuperview()
        }
        
        labelsInWall.forEach{
            $0.removeFromSuperview()
        }
        
        labelsInWall = [UILabel]()
        activeLabels = [UILabel]()
    }
    
    func onDone()
    {
        currentLabel?.removeFromSuperview()
        currentLabel = nil
        
        labelsInWall.append(contentsOf: activeLabels)
        activeLabels = [UILabel]()
        
    }
    
    
    
    override func update(deltaTime seconds: TimeInterval) {
        DispatchQueue.main.async {
            self.updateLabels(labels: self.activeLabels, lines: self.connectingLineProcessor.activeLines)
            self.updateLabels(labels: self.labelsInWall, lines: self.connectingLineProcessor.linesInWall)
            self.updateCurrentLabel()
        }
    }
    
    
}
