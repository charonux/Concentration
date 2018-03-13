import UIKit
class ViewController: UIViewController {
    //"connection, green arrow from MVC,object, instance" that connects Controller to the Model
    //lazy means that it doesnt actually initialize until someone grabs it
    //private special because numberOfPairsOfCards is strong related to the number of acards in the UI
    private lazy var game = Concentration(numberOfPairsOfCards: (numberOfPairsOfCards))
    
    var numberOfPairsOfCards: Int { //computed property, if it only read only, get is not necessary
        return (cardButtons.count + 1) / 2
    }
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func newGame(_ sender: UIButton) {
        game.gameScore = 0
        game.flipCount = 0
        emoji.removeAll()
        game.newGame()
        updateViewFromModel()
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        if game.flipCount == 0 {
            emojiChoices = returnRandomTheme()
        }
        if let cardNumber = cardButtons.index(of: sender) {
            //pass to the model to handle
            game.chooseCard(at: cardNumber)
            //after the informing of the Model above, it might change
            //thats why here we must update also our View from the Model
            updateViewFromModel()
        }
    }
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            flipCountLabel.text = "Flips: \(game.flipCount)"
            if card.isFaceUp {
                button.setTitle(emoji( for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
            scoreLabel.text = "Score: \(game.gameScore)"
        }
    }
    private var themeOfEmojies = [Int:[String]]()
    private var emojiChoices = [String]()
    private var emoji = [Int:String]()
    private func returnRandomTheme() -> [String] {
        themeOfEmojies[0] = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎","🌓"]
        themeOfEmojies[1] = ["😀","😅","😇","😍","😙","😛","🤪","🤩","😟","😖"]
        themeOfEmojies[2] = ["🏐","🏉","🏈","⚽️","🎱","⚾️","🏀","🎾","🏓","🏒"]
        themeOfEmojies[3] = ["🏄‍♀️","🏊‍♀️","🚴‍♀️","🤽‍♀️","🏌️‍♂️","🏋️‍♂️","🏇","⛷","🏂","🤺"]
        themeOfEmojies[4] = ["🐶","🐱","🐭","🐰","🦊","🐻","🐼","🐸","🐧","🐥"]
        themeOfEmojies[5] = ["🍐","🍉","🥥","🌽","🥕","🥦","🥝","🍋","🍌","🍑"]
        return themeOfEmojies[themeOfEmojies.count.arc4random]!
    }
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self)))) //?check why - an also abs for negative values
        } else {
            return 0
        }
    }
}




