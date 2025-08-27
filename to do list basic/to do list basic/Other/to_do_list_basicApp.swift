//
//  to_do_list_basicApp.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/20.
//

import FirebaseCore
import SwiftUI

@main
struct to_do_list_basicApp: App {
    init() {
        FirebaseApp.configure() 
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        
    }
}
