//
//  Helper.swift
//  ScaredyCat
//
//  Created by Victor Huang on 8/5/17.
//  Copyright © 2017 Victor Huang. All rights reserved.
//

import Foundation

func RandomDouble(min: Double, max: Double) -> Double {
    return (Double(arc4random()) / Double(UInt32.max)) * (max - min) + min
}

func RandomInt(min: Int, max: Int) -> Int {
    if max < min { return min }
    return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
}
