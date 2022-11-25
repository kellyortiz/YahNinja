//
//  CGFloat+Ext.swift
//  YahNinja
//
//  Created by Kelly Ortiz Figueiredo on 25/11/22.
//

import CoreGraphics

public let π = CGFloat.pi

extension CGFloat{
    func radiansToDegrees() -> CGFloat{
        return self * 180.0 / π
    }
    
    func degreesToRadians() -> CGFloat{
        return self * π / 180.0
    }
}
