//
//  ViewController.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 07/03/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // MARK: variables
    // Theme will be set by other ViewController.
    var theme = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"] {
        didSet{
            emojiChoices = theme
            emoji = [:]
            // Added nil check - Because in some cases this property may be set before ViewController has been loaded (Since it is set from other controller).
            if cardButtons != nil{
                updateViewFromModel()
            }
        }
    }
    
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var emojiChoices = [String]()
    private var emoji = [Int: String]()
    private var game: Concentration!
    var noOfPairOfCards: Int {
        return (cardButtons.count/2)
    }
    
    // MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: Action Methods.
    // Gets invoked on touch of card.
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // Gets invoked on touch of newCard.
    @IBAction private func newGame(_ sender: UIButton) {
        setUp()
    }
    
    // MARK: Private Functions
    private func setUp(){
        game = Concentration(noOfPairOfCards: noOfPairOfCards)
        emojiChoices = theme
        emoji = [:]
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card : Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self>0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if(self < 0){
            return Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
}

