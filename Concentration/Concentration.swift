//
//  Concentration.swift
//  Concentration
//
//  Created by Kay Remus Barth on 26/01/2018.
//  Copyright © 2018 Kay Remus Barth. All rights reserved.
//
import Foundation
//class have inheritance and they are reference types
class Concentration {
    var gameScore = 0
    var flipCount = 0
    var scoreMismatchPenalty = Array(repeating: 0, count: 20)
    //public property
    var cards = [Card]()//Array have also a init with no arguments to create an epmty array
    var indexOfOneAndOnlyFaceUpCard: Int?
    //public API method, user can only interact by choosing a card
    func chooseCard(at index: Int){ //choosing card by index
        flipCount += 1
        if !cards[index].isMatched {
            scoreMismatchPenalty[index] += 1 //the card is known now
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                    scoreMismatchPenalty[index] = 0
                    scoreMismatchPenalty[matchIndex] = 0
                }
                for temporaryIndex in 0...scoreMismatchPenalty.count - 1 {
                    if scoreMismatchPenalty[temporaryIndex] == 2 {
                       gameScore -= 1
                       scoreMismatchPenalty[temporaryIndex] = 0
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        for _ in 1...numberOfPairsOfCards * 2 {
            let positionOne = Int(arc4random_uniform(UInt32(numberOfPairsOfCards * 2)))
            let positionTwo = Int(arc4random_uniform(UInt32(numberOfPairsOfCards * 2)))
            if positionOne != positionTwo {
                let temporaryCard = cards[positionOne]
                cards[positionOne] = cards[positionTwo]
                cards[positionTwo] = temporaryCard
            }
        }
    }
}
