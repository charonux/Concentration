//
//  Card.swift
//  Concentration
//
//  Created by Kay Remus Barth on 26/01/2018.
//  Copyright © 2018 Kay Remus Barth. All rights reserved.
//

import Foundation
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    //a static func is used only by the "TYPE" Card not by an object/instance card
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // or Card.identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
