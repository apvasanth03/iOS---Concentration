//
//  Card.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 30/04/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory+=1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
    
    
}
