//
//  Concentration.swift
//  concentration
//
//  Created by Apple Macbook on 12/02/2018.
//  Copyright © 2018 Apple Macbook. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards: [Card]
    private(set) var flipsAmount: Int
    private(set) var score: Int
    private var seenAlready : Set<Card>
    private var lastTapDate: Date
    
    private var indexOfOneAndOnlyFaceUp : Int? {
        return cards.indices.filter({return cards[$0].isFaceUp}).oneAndOnly
    }
    
    mutating func cardSelected(at index : Int) {
        if cards[index].isMatched {
            return
        }
        
        let interval = lastTapDate.timeIntervalSinceNow
        if(interval < -3) {
            score -= 1
        }
        flipsAmount += 1
        
        if indexOfOneAndOnlyFaceUp == nil {
            firstSelectedCard(index)
        }
        else if cards[indexOfOneAndOnlyFaceUp!] == cards[index] && indexOfOneAndOnlyFaceUp != index{
            cardsAreEqual(index, interval)
        }
        else if indexOfOneAndOnlyFaceUp != index{
            cardsAreDifferent(index)
        }
        cards[index].isFaceUp = true
        lastTapDate = Date()
    }
    
    init(couplesNum : Int) {
        cards = [Card]()
        lastTapDate = Date()
        seenAlready = Set()
        score = 0
        flipsAmount = 0
        
        for _ in 1...couplesNum {
            let card = Card()
            cards += [card, card]
        }
        shuffle()
    }
    
    private mutating func shuffle(){
        var ret = [Card]()
        var randNum = 0
        let count = cards.count
        for _ in 1...count {
            randNum = Int(arc4random_uniform(UInt32(cards.count)))
            ret.append(cards.remove(at: randNum))
        }
        cards = ret
    }
    
    private mutating func flipCards() {
        for i in cards.indices {
            cards[i].isFaceUp = false
        }
    }
    
    private mutating func firstSelectedCard(_ index: Int) {
        seenAlready.insert(cards[index])
        flipCards()
    }
    
    private mutating func cardsAreEqual(_ index: Int, _ interval: TimeInterval) {
        cards[indexOfOneAndOnlyFaceUp!].isMatched = true
        cards[index].isMatched = true
        score += 2
        if interval > -1 {
            score += 1
        }
    }
    
    private mutating func cardsAreDifferent(_ index: Int) {
        if seenAlready.contains(cards[index]) {
            score -= 1
        }
        else {
            seenAlready.insert(cards[index])
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {return count == 1 ? first : nil}
}



















