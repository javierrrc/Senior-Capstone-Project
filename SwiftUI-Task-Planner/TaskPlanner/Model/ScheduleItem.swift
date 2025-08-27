//
//  ToDoListItem.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import Foundation

struct ScheduleItem: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let startTime: TimeInterval
    let endTime: TimeInterval
    let createdDate: Double
    let repeated: [Bool]
    var isDone: Bool
    
    mutating func setDone (_ state: Bool){
        isDone = state
    }
    
//    static func ==(a: ToDoListItem, b: ToDoListItem) -> Bool {
//        return a.id == b.id
//    }
}
