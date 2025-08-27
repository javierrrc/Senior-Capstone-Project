//
//  ToDoListItem.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone (_ state: Bool){
        isDone = state
    }
}
