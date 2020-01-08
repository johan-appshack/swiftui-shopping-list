//
//  ListItem.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import Foundation
import RealmSwift

enum AmountUnit: Int {
    case none = -1
    case units = 0
    case grams = 1
    case milliliters = 2
    case deciliters = 3
    case liters = 4
}

class ListItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var amountUnitIntRepresentation: Int = -1
    @objc dynamic var timesUsed: Int = 0
    @objc dynamic var showAmount: Bool = false
    @objc dynamic var isInCurrentList: Bool = true
    @objc dynamic var isDone: Bool = false
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    var amountUnit: AmountUnit {
        return AmountUnit(rawValue: amountUnitIntRepresentation) ?? .none
    }
    
}
