//
//  User.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
