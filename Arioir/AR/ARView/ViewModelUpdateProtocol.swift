//
//  ViewModelUpdateProtocol.swift
//  Arioir
//
//  Created by Максим Спиридонов on 28.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import UIKit

protocol ViewModelUpdateProtocol
{
    func updateHeightLabel(height: CGFloat)
    
    func activateHeightLabel()
    
    func deactivateHeightLabel()
}

