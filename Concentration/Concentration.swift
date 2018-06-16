//
//  Concentration.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 30/04/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import Foundation

class Concentration{
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    private(set) var noOfFilips = 0
    private(set) var score = 0
    
    init(noOfPairOfCards: Int) {
        assert(noOfPairOfCards>0, "Concentration.init(\(noOfPairOfCards): you must have atleast one pair of cards ")
        
        for _ in 0..<noOfPairOfCards{
            let card = Card()
            cards += [card, card] // Struct is a value type, hence it will be copied.
        }
        
        suffleCards() // Suffle cards.
    }
    
    // Suffle the cards.
    private func suffleCards(){
        var temp = [Card]()
        for _ in cards{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            temp.append(cards.remove(at: randomIndex))
        }
        cards = temp
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index):  chosen index is not in the cards")
        
        if !cards[index].isMatched{
            noOfFilips += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // One card is already faceUp & second card has been choosed.
                if cards[matchIndex] == cards[index]{
                    // Matched.
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += 2
                }else{
                    // Not Matched.
                    if (cards[matchIndex].isSeenBefore || cards[index].isSeenBefore){
                        score -= 1
                    }
                    cards[index].isSeenBefore = true
                    cards[matchIndex].isSeenBefore = true
                }
                cards[index].isFaceUp = true
            }else{
                // either no card or two card is already faceup.
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

extension Collection{
    // If collection contains only one item, then return that item else nil
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
