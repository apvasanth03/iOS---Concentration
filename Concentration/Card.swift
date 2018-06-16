//
//  Card.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 30/04/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import Foundation

struct Card : Hashable{
    
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    private(set) var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
    // Hashable.
    var hashValue: Int{
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.identifier == rhs.identifier)
    }
    
}
