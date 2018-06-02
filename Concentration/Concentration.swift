//
//  Concentration.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 30/04/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int? = nil
    var noOfFilips = 0
    var score = 0
    var previouslySeenCards = [Int]()
    
    init(noOfPairOfCards: Int) {
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
        if !cards[index].isMatched{
            noOfFilips += 1
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // One card is already faceUp & second card has been choosed.
                if cards[matchIndex].identifier == cards[index].identifier{
                    // Matched.
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    score += 2
                }else{
                    // Not Matched.
                    if(previouslySeenCards.contains(cards[matchIndex].identifier)){
                        score -= 1
                    }
                    if(previouslySeenCards.contains(cards[index].identifier)){
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
                addCardsToPreviouslySeenCards(first: cards[matchIndex], second: cards[index])
            }else{
                // either no card or two card is already faceup.
                for filpDownIndex in cards.indices{
                    cards[filpDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    private func addCardsToPreviouslySeenCards(first: Card, second: Card){
        // Add if it is not already present.
        if(!previouslySeenCards.contains(first.identifier)){
            previouslySeenCards.append(first.identifier)
        }
        
        if(!previouslySeenCards.contains(second.identifier)){
            previouslySeenCards.append(second.identifier)
        }
    }
    
}
