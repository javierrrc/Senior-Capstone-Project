//
//  ToDoListItem.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import Foundation

struct ToDoListItem: Codable, Identifiable, Equatable {
    let id: String
    var listId: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    var selected: Bool
    var showInMainList: Bool
    var folderId: String
    
    mutating func setDone (_ state: Bool){
        isDone = state
    }
    
    mutating func setSelected (_ state: Bool){
        selected = state
    }
    
    mutating func setlistId(_ listId: String){
        self.listId = listId
    }
}
