//
//  ViewController.swift
//  concentration
//
//  Created by Apple Macbook on 12/02/2018.
//  Copyright © 2018 Apple Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var game = Concentration(couplesNum: constents.numOfCouples)
    private var emojis = [String]()
    private var emojiTable = [Int : String]()
    private var cardBackroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    
    @IBOutlet private weak var ScoreLabel: UILabel!
    
    @IBOutlet private weak var flipsLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.cardSelected(at: cardButtons.index(of: sender)!)
        updateViewFromModel()
    }
    
    @IBAction private func newGame() {
        game = Concentration(couplesNum: constents.numOfCouples)
        emojis = getEmojisRandomTheme()
        emojiTable = [Int : String]()
        cardBackroundColor = generateCardBackround(emojiTheme: emojis)
        generateViewBackroundColor(cardBackRoundColor: cardBackroundColor)
        
        updateViewFromModel()
    }
    
    
    
    fileprivate func updateButtons() {
        for i in cardButtons.indices {
            let card = game.cards[i]
            let cardButton = cardButtons[i]
            
            if(card.isMatched && card.isFaceUp == false){
                disapearTheButton(cardButton)
            }
            else if(card.isFaceUp){
                showTheButtonFace(cardButton, card)
            }
            else {
                showTheButtonBack(cardButton)
            }
        }
    }
    
    override func viewDidLoad() {
        newGame()
    }
    
    private func updateViewFromModel() {
        flipsLabel.text = "Flips: \(game.flipsAmount)"
        ScoreLabel.text = "Score: \(game.score)"
        
        updateButtons()
    }
    
    private func emoji(for card : Card) -> String {
        if(emojiTable[card.hashValue] == nil) {
            if(emojis.count > 0) {
                emojiTable[card.hashValue] = emojis.remove(at: 0)
            }
        }
        return emojiTable[card.hashValue] ?? "?"
    }
    
    private func getEmojisRandomTheme() -> [String] {
        let animals = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼"]
        let sports = ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱"]
        let faces = ["😀","☺️","😇","🙃","😍","😡","😂","🤪"]
        let veichles = ["🚗","🚌","🚑","✈️","🛴","🚲","🛵","🚀"]
        let flags = ["🇩🇿","🇦🇸","🇦🇩","🇨🇳","🇨🇦","🇨🇲","🇨🇮","🇦🇲"]
        let fruits = ["🍏","🍊","🍋","🍌","🍉","🍇","🍓","🍍"]
        
        var possibleThemes = [animals, sports, faces, veichles, flags, fruits]
        return possibleThemes[Int(arc4random_uniform(UInt32(possibleThemes.count)))]
    }
    
    private func generateCardBackround(emojiTheme emojis: [String]) -> UIColor {
        switch emojis[0] {
        case "🐶":
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case "⚽️":
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case "😀":
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case "🚗":
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case "🇩🇿":
            return #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        case "🍏":
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        default:
            return #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
    }
    
    private func generateViewBackroundColor(cardBackRoundColor color: UIColor) {
        switch color {
        case #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1):
            view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        default:
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    fileprivate func disapearTheButton(_ cardButton: UIButton) {
        cardButton.setTitle("", for: UIControlState.normal)
        cardButton.backgroundColor = view.backgroundColor
    }
    
    fileprivate func showTheButtonFace(_ cardButton: UIButton, _ card: Card) {
        cardButton.setTitle(emoji(for : card), for: UIControlState.normal)
        cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func showTheButtonBack(_ cardButton: UIButton) {
        cardButton.backgroundColor = cardBackroundColor
        cardButton.setTitle("", for: UIControlState.normal)
    }
}

extension ViewController {
    struct constents {
        static let numOfCouples = 8
    }
}




























