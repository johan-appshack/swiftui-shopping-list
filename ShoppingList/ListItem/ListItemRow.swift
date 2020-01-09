//
//  ListItemRow.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import SwiftUI

struct ListItemRow: View {
    private let viewModel: ListItemViewModel

    init(viewModel: ListItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack { Text(viewModel.item.title).foregroundColor(.white) }
    }
}
