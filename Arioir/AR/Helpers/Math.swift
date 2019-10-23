//
//  Math.swift
//  demo-uni
//
//  Created by Alexey Antipin on 09/03/2019.
//  Copyright © 2019 Tim Zagirov. All rights reserved.
//


import SceneKit

func * (_ a:SCNVector3, _ b:SCNVector3) -> Float
{
    return a.x * b.x + a.y * b.y + a.z * b.z
}

func * (_ a:SCNVector3, _ b:SCNVector3) -> SCNVector3
{
    return SCNVector3Make(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x)
}

func * (_ a:SCNVector3, _ b:Float) -> SCNVector3
{
    return SCNVector3Make(a.x * b, a.y * b, a.z * b)
}

func * ( _ b:Float, _ a:SCNVector3) -> SCNVector3
{
    return SCNVector3Make(a.x * b, a.y * b, a.z * b)
}



func / (_ a:SCNVector3, _ b:Float) -> SCNVector3
{
    return SCNVector3Make(a.x / b, a.y / b, a.z / b)
}

func / (_ a:SCNVector3, _ b:Int) -> SCNVector3
{
    let invB = 1.0 / Float(b)
    return SCNVector3Make(a.x * invB, a.y * invB, a.z * invB)
}

func + (_ a: SCNVector3, _ b:SCNVector3) -> SCNVector3
{
    return SCNVector3Make(a.x + b.x, a.y + b.y, a.z + b.z)
}

func norm(_ vector: SCNVector3) -> Float
{
    return (sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z))
}

func - (_ a: SCNVector3, _ b:SCNVector3) -> SCNVector3
{
    return SCNVector3Make(a.x - b.x, a.y - b.y, a.z - b.z)
}

extension simd_float4
{
    func toSCNVector3() ->SCNVector3
    {
        return SCNVector3Make(x, y, z)
    }
}
