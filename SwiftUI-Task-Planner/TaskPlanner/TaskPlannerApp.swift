//
//  to_do_list_basicApp.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/20.
//

import FirebaseCore
import SwiftUI

@main
struct TaskPlannerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var settings = SettingsViewViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(settings)
        }
        .modelContainer(for: Task.self)
    }
}
