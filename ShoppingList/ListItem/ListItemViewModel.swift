//
//  ListItemViewModel.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import Foundation

struct ListItemViewModel: Identifiable {
    let item: ListItem
    
    var id: String {
        return item.title
    }
    
    init(item: ListItem) {
        self.item = item
    }
}
