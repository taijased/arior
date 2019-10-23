//
//  UIrecognizer.swift
//  ARI-AR
//
//  Created by Alexey Antipin on 16/08/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import UIKit
extension UIGestureRecognizer {
    func center(in view: UIView) -> CGPoint
    {
        let first = CGRect(origin: location(ofTouch: 0, in: view), size: .zero)
        let touchBounds = (1..<numberOfTouches).reduce(first) { touchBounds, index in
            return touchBounds.union(CGRect(origin: location(ofTouch: index, in: view), size: .zero))
        }
        return CGPoint(x: touchBounds.midX, y: touchBounds.midY)
    }
}
