//
//  ToDoListItem.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import Foundation

struct Folder: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let folderId: String
    let createdDate: TimeInterval
}
