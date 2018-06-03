import Foundation
struct Concentration {
    var gameScore = 0
    var flipCount = 0
    private var scoreMismatchPenalty = Array(repeating: 0, count: 20)
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int? // a good case of using optional
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil //there are two cards
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue) //cool trick
            }
        }
    }
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
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
    mutating func newGame() {
        indexOfOneAndOnlyFaceUpCard = nil
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concetration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        for _ in 1...numberOfPairsOfCards * 2 {
            let positionOne = (numberOfPairsOfCards * 2).arc4random
            let positionTwo = (numberOfPairsOfCards * 2).arc4random
            if positionOne != positionTwo {
                let temporaryCard = cards[positionOne]
                cards[positionOne] = cards[positionTwo]
                cards[positionTwo] = temporaryCard
            }
        }
    }
}
