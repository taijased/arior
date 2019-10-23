//
//  ViewModelUpdateProtocol.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 17/10/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

protocol ViewModelUpdateProtocol
{
    func updateHeightLabel(height: CGFloat)
    
    func activateHeightLabel()
    
    func deactivateHeightLabel()
}
