//
//  ViewController.swift
//  Concentration
//
//  Created by Kay Remus Barth on 02/01/2018.
//  Copyright © 2018 Kay Remus Barth. All rights reserved.
//

//Bring all the UIKIt for our use
import UIKit
//Declaration of a class, UIViewController is its superclass that is inherited
//The class UIViewController is in/from UIKit you can tell from the prefix UI
//UIViewController knows everything about controlling a UI interface
class ViewController: UIViewController {
    
    //property observer can be use to keep the UI in sync with instance variables
    var flipCount  = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃","👻","🎃","👻"]
    
    //Swift method, @IBAction is a special directive to show, in this case which button send this meassage
    //and invoke this method. func is a keyword that say that this is a function, in this case a method
    //touchCard is the name of the method, in pranthases we have a list of argument/s, : UIButton is the type of the argument
    //_ sender are the names(external for the caller, internal, to be use inside of method) of this parameter
    @IBAction func touchCard(_ sender: UIButton) {
        //becouse of external names its possible to call as you speak in english
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        
    }
    
    
    
    func flipCard(withEmoji emoji: String,  on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
    
}
