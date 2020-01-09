//
//  ContentViewModel.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var suggestionListItems: [ListItem] = []
    @Published var currentListItems: [ListItemViewModel] = []
    
    private let dataStorageManager: DataStorageProtocol
    
    init(dataStorageManager: DataStorageProtocol = DataStorageManager(),
         scheduler: DispatchQueue = DispatchQueue(label: "ContentViewModel")) {
        self.dataStorageManager = dataStorageManager
        fetchCurrentListItems()
        observeInput()
    }
    
    private func observeInput() {
        
    }
    
    func storeInput() {
        dataStorageManager.storeListItem(inputText: inputText)
        inputText = ""
        fetchCurrentListItems()
    }
    
    private func fetchCurrentListItems() {
        currentListItems = dataStorageManager.getCurrentListItems().map{ListItemViewModel(item: $0)}
    }
    
    private func fetchSuggestions() {
        
    }
    
    func toggleIsInList(itemIndex: Int) {
        dataStorageManager.toggleIsInList(for: currentListItems[itemIndex].item)
        fetchCurrentListItems()
    }
}
