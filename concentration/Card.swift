//
//  Card.swift
//  concentration
//
//  Created by Apple Macbook on 12/02/2018.
//  Copyright © 2018 Apple Macbook. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int { return uniqueIdentity }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        if lhs.uniqueIdentity == rhs.uniqueIdentity{
            return true
        }
        return false
    }
    
    private static var createdNum = 0
    
    var isFaceUp = false
    var isMatched = false
    private var uniqueIdentity : Int
    
    init() {
        uniqueIdentity = Card.createdNum
        Card.createdNum += 1
    }
    
}
