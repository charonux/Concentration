import UIKit
class ViewController: UIViewController {
    //"connection, green arrow from MVC,object, instance" that connects Controller to the Model
    //lazy means that it doesnt actually initialize until someone grabs it
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func newGame(_ sender: UIButton) {
        game.gameScore = 0
        game.flipCount = 0
        emoji.removeAll()
        game.indexOfOneAndOnlyFaceUpCard = nil
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        updateViewFromModel()
    }
    @IBAction func touchCard(_ sender: UIButton) {
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
    func updateViewFromModel(){
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
    var themeOfEmojies = [Int:[String]]()
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
    func returnRandomTheme() -> [String] {
        themeOfEmojies[0] = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎","🌓"]
        themeOfEmojies[1] = ["😀","😅","😇","😍","😙","😛","🤪","🤩","😟","😖"]
        themeOfEmojies[2] = ["🏐","🏉","🏈","⚽️","🎱","⚾️","🏀","🎾","🏓","🏒"]
        themeOfEmojies[3] = ["🏄‍♀️","🏊‍♀️","🚴‍♀️","🤽‍♀️","🏌️‍♂️","🏋️‍♂️","🏇","⛷","🏂","🤺"]
        themeOfEmojies[4] = ["🐶","🐱","🐭","🐰","🦊","🐻","🐼","🐸","🐧","🐥"]
        themeOfEmojies[5] = ["🍐","🍉","🥥","🌽","🥕","🥦","🥝","🍋","🍌","🍑"]
        let randomIndex = Int(arc4random_uniform(UInt32(themeOfEmojies.count)))
        return themeOfEmojies[randomIndex]!
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
