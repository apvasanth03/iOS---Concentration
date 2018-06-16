//
//  ViewController.swift
//  Concentration
//
//  Created by Vasanthakumar Annadurai on 07/03/18.
//  Copyright © 2018 Vasanthakumar Annadurai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: variables
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var theme: [[String]] = []
    private var randomTheme: [String] = []
    private var animals: [String] = []
    private var sports: [String] = []
    private var faces: [String] = []
    private var cars: [String] = []
    private var flags: [String] = []
    private var foods: [String] = []
    private var emoji = [Int: String]()
    private var game: Concentration!
    var noOfPairOfCards: Int {
        return (cardButtons.count+1)
    }
    
    // MARK: Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: Functions
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
        setupTheme()
        emoji = [:]
        updateViewFromModel()
    }
    
    private func setupTheme() {
        animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
        sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"]
        faces = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"]
        cars = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"]
        flags = ["🇹🇼", "🇯🇵", "🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇱🇷", "🎌", "🇨🇦", "🇳🇵", "🇬🇪"]
        foods = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"]
        theme = [animals, sports, faces, cars, flags, foods]
        randomTheme = getRandomTheme()
    }
    
    private func getRandomTheme() -> [String] {
        let index = theme.count.arc4random
        return theme[index]
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card : Card) -> String{
        if emoji[card.identifier] == nil, randomTheme.count > 0{
            emoji[card.identifier] = randomTheme.remove(at: randomTheme.count.arc4random)
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

