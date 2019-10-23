//
//  Pointer.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 28/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit
import GameplayKit

class Pointer: VirtualObject
{

    var wasMagnited: Bool = false
    
    lazy var stickNode = self.node.childNode(withName: "stick", recursively: false)
    lazy var stick = stickNode?.geometry as! SCNCylinder
    
    func dropPointerRing()
    {
        guard let ringNode = geometryComponent.node.childNode(withName: "tube", recursively: false) else {return}
        ringNode.removeFromParentNode()
    }
    
}
