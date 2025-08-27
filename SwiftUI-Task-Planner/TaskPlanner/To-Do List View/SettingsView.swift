//
//  ProfileView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewViewModel
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
                
            }
            .preferredColorScheme(.dark)
        }
        .onAppear() {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile (user: User) -> some View {
        NavigationView {
            List {
                //profile
                Section {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.blue)
                            .frame(width: 50, height: 50)
                            .padding(5)
                        
                        VStack (alignment: .leading) {
                            Text(user.name)
                                .bold()
                                .font(.title3)
                            Text(user.email)
                        }
                    }
                }
                Section {
                    Toggle("Show completed todos", isOn: $viewModel.showCompletedTodos)
//                    NavigationLink(destination: TEST()) {
//                        Text("Edit Folders")
//                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Log Out") {
                            viewModel.logOut()
                        }
                        .foregroundColor(Color.red)
                        Spacer()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func profileDefault (user: User) -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.blue)
            .frame(width: 125, height: 125)
            .padding()
        
        //Info: name email
        VStack(alignment: .leading) {
            HStack {
                Text("Name: ")
                    .bold()
                Text(user.name)
            }
            
            HStack {
                Text("Email: ")
                    .bold()
                Text(user.email)
            }
            
        }
        .padding()
        
        //sign out
        Button ("Log Out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        
        Spacer()
    }
}

#Preview {
    SettingsView()
}
