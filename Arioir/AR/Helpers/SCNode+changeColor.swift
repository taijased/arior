//
//  SCNode+changeColor.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 09/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import SceneKit

extension SCNNode
{
    
    func changeColor(color: UIColor)
    {
        geometry?.firstMaterial?.diffuse.contents = color
    }
    
}
