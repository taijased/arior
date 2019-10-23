//
//  ARSCNView+nodeAt.swift
//  ARI-AR
//
//  Created by Alexey Antipin on 16/08/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import ARKit

extension ARSCNView {
    func nodeAt(point: CGPoint) -> SCNNode! {
        let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResults = hitTest(point, options: hitTestOptions)
        return hitTestResults.first?.node
    }
}
