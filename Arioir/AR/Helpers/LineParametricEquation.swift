//
//  LineEquation.swift
//  ARI-AR
//
//  Created by Alexey Antipin on 26/08/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import SceneKit

///Represent straight line parametric equation
struct LineParametricEquation
{
    var startPoint: SCNVector3
    var directionVector: SCNVector3
    var type: LineType
    
    enum LineType {
        case parallel
        case perpendicular
    }
    
    
    init(startPoint: SCNVector3, directionVector: SCNVector3, type: LineType) {
        self.startPoint = startPoint
        self.directionVector = directionVector / norm(directionVector)
        self.type = type
    }
    
    func distanceFromPoint(point: SCNVector3) -> Float
    {
        return norm((startPoint - point) * directionVector)
    }
    
    func pointOnLineParameter(to point: SCNVector3) -> Float
    {
        return  directionVector * (point - startPoint)
    }
    
    func nearestPointOnLine(to point: SCNVector3) -> SCNVector3
    {
        
        let t: Float = pointOnLineParameter(to: point)
        return pointOnLine(parameter: t)
        
    }
    
    func nearestPointOnLine(to point: SCNVector3) ->(SCNVector3, Float)
    {
        let t: Float = pointOnLineParameter(to: point)
        return (pointOnLine(parameter: t), t)
    }
    
    func intersectionPointWithLine(equation: LineParametricEquation!) -> SCNVector3!
    {
        guard let eq = equation  else { return nil }
        return intersectionPointWithLine(startPoint: eq.startPoint, directionVector: eq.directionVector)
    }
    
    func intersectionPointWithLine(startPoint: SCNVector3, directionVector: SCNVector3) -> SCNVector3!
    {
        let equationOne = float2(self.directionVector.x, directionVector.x)
        let equationTwo = float2(self.directionVector.y, directionVector.y)
        let equationThree = float2(self.directionVector.z, directionVector.z)
        
        var equationMatrix = simd_float2x2(rows: [equationOne, equationTwo])
        
        let eps:Float = 1e-4
        var d = equationMatrix.determinant
        if d < -eps || d > eps
        {
            let rightPart = simd_float2(startPoint.x - self.startPoint.x, startPoint.y - self.startPoint.y)
            let parameters = simd_mul(equationMatrix.inverse, rightPart)
            return pointOnLine(parameter: parameters.x)
        }
        equationMatrix = simd_float2x2(rows: [equationOne, equationThree])
        d = equationMatrix.determinant
        if d < -eps || d > eps
        {
            let rightPart = simd_float2(startPoint.x - self.startPoint.x, startPoint.z - self.startPoint.z)
            let parameters = simd_mul(equationMatrix.inverse, rightPart)
            return pointOnLine(parameter: parameters.x)
        }
        equationMatrix = simd_float2x2(rows: [equationTwo, equationThree])
        d = equationMatrix.determinant
        if d < -eps || d > eps
        {
            let rightPart = simd_float2(startPoint.y - self.startPoint.y, startPoint.z - self.startPoint.z)
            let parameters = simd_mul(equationMatrix.inverse, rightPart)
            return pointOnLine(parameter: parameters.x)
        }
        return nil
    }
    
    func pointOnLine(parameter: Float) -> SCNVector3
    {
        return SCNVector3Make(startPoint.x + directionVector.x * parameter, startPoint.y + directionVector.y * parameter, startPoint.z + directionVector.z * parameter)
    }
    
    func isParallel( with line: LineParametricEquation, epsilon: Float) -> Bool
    {
        let cosine = directionVector * line.directionVector / norm(directionVector) / norm(line.directionVector)
        let a = 1 - abs(cosine)
        if a > -epsilon && a < epsilon
        {
            return true
        }
        else
        {
            return false
        }
    }
}
