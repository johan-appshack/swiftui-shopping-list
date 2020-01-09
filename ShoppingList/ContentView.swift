//
//  ContentView.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                List {
                    TextField("e.g. Milk", text: $viewModel.inputText, onCommit: didCommitInput).background(Color.clear)
                    
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Text("No suggestions found").foregroundColor(Color.red)
                            }
                        }
                    }
                    
                    if viewModel.currentListItems.isEmpty {
                        Section {
                            Text("Nothing found").foregroundColor(Color.red)
                        }
                    } else {
                        currentItemsSection
                    }
                }
            }
            .padding(.top, 50)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                       startPoint: .top,
                                       endPoint: .bottom))
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    var currentItemsSection: some View {
        Section {
            ForEach(viewModel.currentListItems, content: ListItemRow.init(viewModel:)).onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        viewModel.toggleIsInList(itemIndex: offsets.first ?? 0)
    }
    
    private func didCommitInput() {
        viewModel.storeInput()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
