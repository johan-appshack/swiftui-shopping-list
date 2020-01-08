//
//  DataStorageManager.swift
//  ShoppingList
//
//  Created by Johan Jönsson on 2020-01-08.
//  Copyright © 2020 Joennelito. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataStorageProtocol {
    func storeListItem(inputText: String)
    func searchListItems(searchString: String, exactMatch: Bool) -> [ListItem]
    func getCurrentListItems() -> [ListItem]
}

class DataStorageManager: DataStorageProtocol {
    let realm: Realm?
    
    init() {
        do {
            try realm = Realm()
        } catch {
            print("Failed to init Realm with error: \(error.localizedDescription)")
            realm = nil
        }
    }
    
    func storeListItem(inputText: String) {
        guard let realm = realm else { return }
        
        if let existingItem = searchListItems(searchString: inputText, exactMatch: true).first {
            do {
                try realm.write {
                    existingItem.timesUsed += 1
                    existingItem.showAmount = false
                    existingItem.isInCurrentList = true
                    existingItem.isDone = false
                }
            } catch {
                print("Failed to update existing list item due to error: \(error.localizedDescription)")
            }
        } else {
            let listItem = ListItem(title: inputText)
            do {
                try realm.write {
                    realm.add(listItem)
                }
           } catch {
                print("Failed to create list item due to error: \(error.localizedDescription)")
           }
        }
    }
    
    func searchListItems(searchString: String, exactMatch: Bool) -> [ListItem] {
        guard let realm = realm else { return [] }
        
        let filterPredicate = exactMatch
            ? "title = '\(searchString)'"
            : "title BEGINSWITH[c] '\(searchString)'"
        
        var result: [ListItem]!
        
        if searchString.isEmpty {
            result = realm.objects(ListItem.self)
                .sorted(byKeyPath: "timesUsed", ascending: false)
                .map({$0})
        } else {
            result = realm.objects(ListItem.self)
                .filter(filterPredicate)
                .sorted(byKeyPath: "timesUsed", ascending: false)
                .map({$0})
        }
        
        return result
    }
    
    func getCurrentListItems() -> [ListItem] {
        guard let realm = realm else { return [] }
        return realm.objects(ListItem.self).filter({$0.isInCurrentList})
    }
    
}
