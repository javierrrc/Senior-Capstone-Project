//
//  ContentView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty {
            // signed in
            accountView
                .onAppear {
                    //patch 1
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(viewModel.currentUserID)
                    
                    userRef.getDocument { document, error in
                        if let document = document, document.exists {
                            let data = document.data()
                            let alreadyPatched = data?["patch1"] as? Bool ?? true
                            
                            if !alreadyPatched {
                                
                                patchAllItemsWithDefaultFolder(userId: viewModel.currentUserID)
                                patchDefaultFolder(userId: viewModel.currentUserID)
                                
                                //Mark as patched
                                userRef.updateData(["patch 1": true]) { error in
                                    if let error = error {
                                        print("Failed to mark as patched: \(error)")
                                    } else {
                                        print("User successfully marked as patched.")
                                    }
                                }
                            }
                        }
                    }
                }
        }
        else {
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
            TaskView(userId: viewModel.currentUserID)
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "person.circle")
                }
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.dark)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//PATCH 1
func patchAllItemsWithDefaultFolder(userId: String) {
    let db = Firestore.firestore()
    let todosRef = db.collection("users").document(userId).collection("todos")
    
    todosRef.getDocuments { snapshot, error in
        guard let docs = snapshot?.documents else { return }
        
        for doc in docs {
            todosRef.document(doc.documentID).updateData([
                "folderId": "default",
                "showInMainList": true
            ])
        }
    }
}

func patchDefaultFolder(userId: String) {
    let db = Firestore.firestore()
    let newId = UUID().uuidString
    let newFolder: Folder
    
    //create model
    newFolder = Folder(id: newId, title: "Reminders", folderId: "default", createdDate: 0)
    
    db.collection("users")
        .document(userId)
        .collection("folders")
        .document(newId)
        .setData(newFolder.asDictionary())
}
