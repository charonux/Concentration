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
    //public property
    var cards = [Card]()//Array have also a ninit with no arguments to create an epty array
    var indexOfOneAndOnlyFaceUpCard: Int?
    //public API method, user can only interact by choosing a card
    func chooseCard(at index: Int){ //choosing card by index
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
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
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]//we do this becouse card is values type
        }
        //TODO: Shuffle the cards
    }
}
