//
//  Time.swift
//  Arior-AR
//
//  Created by Alexey Antipin on 27/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

class Time
{
    static let shared = Time()
    var previousTime: Double = 0
    var currentTime: Double = 0
    
    var deltaTime:Double!
    {
        get
        {
            return currentTime - previousTime
        }
    }
    
    func updateTime(time: Double)
    {
        previousTime = currentTime
        currentTime = time
    }
    
    private init()
    {
        
    }
}
