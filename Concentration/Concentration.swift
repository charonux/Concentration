import Foundation

class Concentration {
    var gameScore = 0
    var flipCount = 0
    var scoreMismatchPenalty = Array(repeating: 0, count: 20)
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var possibleReturnIndex = 0
            var countOfFaceUpCards = 0
            for index in cards.indices {
                if cards[index].isFaceUp {
                    possibleReturnIndex = index
                    countOfFaceUpCards += 1
                }
            }
                if countOfFaceUpCards == 1 {
                    return possibleReturnIndex
                } else {
                    return nil
                }
            }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = false
                }
            }
        }
    }
    func chooseCard(at index: Int) { //choosing card by index
        flipCount += 1
        if !cards[index].isMatched {
            scoreMismatchPenalty[index] += 1 //the card is known now
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                    scoreMismatchPenalty[index] = 0
                    scoreMismatchPenalty[matchIndex] = 0
                    cards[index].isFaceUp = true
                }
                for temporaryIndex in 0...scoreMismatchPenalty.count - 1 {
                    if scoreMismatchPenalty[temporaryIndex] == 2 {
                        gameScore -= 1
                        scoreMismatchPenalty[temporaryIndex] = 0
                    }
                }
                cards[index].isFaceUp = true
            } else {
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
