//
//  ContentView.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var dataSource: [ListItem] = []
    
    private let dataStorageManager: DataStorageProtocol
    
    init(dataStorageManager: DataStorageProtocol = DataStorageManager()) {
        self.dataStorageManager = dataStorageManager
    }
    
}

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TextField("e.g. Milk", text: $viewModel.inputText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
