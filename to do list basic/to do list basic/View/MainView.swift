//
//  ContentView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/20.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty {
            // signed in
            accountView
        } else {
            LoginView()
        }
    }
        
    @ViewBuilder
    var accountView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserID)
                .tabItem {
                    Label("To Do List", systemImage: "list.bullet.clipboard")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
         MainView()
    }
}
