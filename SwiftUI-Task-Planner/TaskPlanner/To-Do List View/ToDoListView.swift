//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseFirestore
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var folders: [Folder]
    var userId: String
    @State private var firstFolderId = ""

    init(userId: String) {
        self._folders = FirestoreQuery(
            collectionPath: "users/\(userId)/folders",
            predicates: [.orderBy("createdDate", false)])
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(folders) { folder in
                        FolderView(userId: self.userId, folderId: folder.folderId, folderName: folder.title)
                            
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.2))
                    }
                }
            }
            .padding(.top, 15)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        Text("To Do List")
                            .font(.title)
                            .bold()
                            .padding(.leading, 0)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack (spacing: 10){
                        Button {
                            viewModel.showingNewFolderView = true
                        } label: {
                            Text("Add List")
                                .foregroundColor(.blue)
                        }
                        
                        Button {
                            //action
                            viewModel.showingNewItemView = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, userId: self.userId)
                    .presentationDetents([.height(350)])
            }
            .sheet(isPresented: $viewModel.showingNewFolderView) {
                NewFolderView(newFolderPresented: $viewModel.showingNewFolderView)
                    .presentationDetents([.height(250)])
            }
            
        }
    }
}

#Preview {
    ToDoListView(userId: "yPihVrTpdvT4bpKOCFB92OeqTly2")
}
