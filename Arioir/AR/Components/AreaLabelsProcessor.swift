//
//  AreaLabelsProcessor.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 14/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class AreaLabelsProcessor: GKComponent
{
    let sceneView: ARSCNView
    let wallBuilder: WallBuilder
    
    var activeLabels = [UILabel]()
    
    init(sceneView: ARSCNView, wallBuilder: WallBuilder)
    {
        self.sceneView = sceneView
        self.wallBuilder = wallBuilder
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLengthLabel() -> UILabel
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

    func onDone(wallSigments: [WallSigment])
    {
        for _ in wallSigments
        {
            activeLabels.append(createLengthLabel())
        }
    }
    
    func updateLabels()
    {
        if activeLabels.isEmpty || wallBuilder.wallSigments.isEmpty
        {
            return
        }
        
        let sigments = wallBuilder.wallSigments
        
        for i in 0..<sigments.count
        {
            let screenCoordinates = sceneView.projectPoint(sigments[i].geometryComponent.node.worldPosition)
            if !screenCoordinates.x.isNaN
            {
                
                let plane = (sigments[i].node.geometry as! SCNPlane)
                let area = plane.height * plane.width
                
                activeLabels[i].text = String(format: "%.2f", area) + " кв. м"
                activeLabels[i].center = CGPoint(x: CGFloat(screenCoordinates.x), y: CGFloat(screenCoordinates.y))
                activeLabels[i].isHidden = false
            }
            else
            {
                activeLabels[i].isHidden = true
            }
        }
        
    }
 
    override func update(deltaTime seconds: TimeInterval) {
        DispatchQueue.main.async {
            self.updateLabels()
        }

    }
    
}
