//
//  ARViewController+.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 27/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import UIKit

extension ARViewController: ARViewModelProtocol
{
    func close() {
        print(#function)
    }
    
    func plus() {
        print(#function)
        arFacade.wallBuilder.addPointer()

    }
    
    func undo() {
        print(#function)
        arFacade.wallBuilder.undo()

    }
    
    func done() {
        print(#function)
        arFacade.wallBuilder.buildWall()
    }
    
    func restart() {
        print(#function)
        arFacade.resetTracking()
    }
    
    
    
}
