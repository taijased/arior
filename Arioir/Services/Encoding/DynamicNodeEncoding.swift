//
//  DynamicNodeEncoding.swift
//  Arioir
//
//  Created by Максим Спиридонов on 22.10.2019.
//  Copyright © 2019 Максим Спиридонов. All rights reserved.
//

import Foundation
import XMLCoder


public protocol DynamicNodeEncoding: Encodable {
    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding
}

public extension DynamicNodeEncoding {
    static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        return XMLEncoder.NodeEncoding.default
    }
}

extension Array: DynamicNodeEncoding where Element: DynamicNodeEncoding {
    public static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        return Element.nodeEncoding(forKey: key)
    }
}

extension DynamicNodeEncoding where Self: Collection, Self.Iterator.Element: DynamicNodeEncoding {
    public static func nodeEncoding(forKey key: CodingKey) -> XMLEncoder.NodeEncoding {
        return Element.nodeEncoding(forKey: key)
    }
}
