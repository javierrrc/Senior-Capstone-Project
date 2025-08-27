//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseFirestore
import SwiftUI

struct SelectListFolderView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    @FirestoreQuery var completedItems: [ToDoListItem]
    var folderName: String
    var folderId: String
    @State private var selectedItem: ToDoListItem? = nil
    private var listId: String

    init(userId: String, folderId: String, folderName: String, listId: String) {
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos",
            predicates: [.orderBy("dueDate", false),
                         .orderBy("createdDate", false),
                         .whereField("showInMainList", isEqualTo: true),
                         .whereField("folderId", isEqualTo: folderId),
                         .whereField("isDone", isEqualTo: false)])
        self._completedItems = FirestoreQuery(
            collectionPath: "users/\(userId)/todos",
            predicates: [.orderBy("dueDate", false),
                         .orderBy("createdDate", false),
                         .whereField("showInMainList", isEqualTo: true),
                         .whereField("folderId", isEqualTo: folderId),
                         .whereField("isDone", isEqualTo: true)])
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
        self.folderName = folderName
        self.folderId = folderId
        self.listId = listId
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Text(folderName)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding(.bottom, 10)
            
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    SelectListItemView(item: item, listId: self.listId)
                        .padding(.vertical, 10)
                        .padding(.leading, 20)
                    if (item.id != items.last!.id) {
                        Divider()
                            .padding(.leading)
                    }
                }
            }
            LazyVStack(spacing: 0) {
                ForEach(completedItems) { compitem in
                    ToDoListItemView(item: compitem)
                        .padding(.vertical, 10)
                        .padding(.leading, 20)
                        .onTapGesture {
                            self.selectedItem = compitem
                            viewModel.showingEditToDoView = true
                        }
                    if (compitem.id != completedItems.last!.id) {
                        Divider()
                            .padding(.leading)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingEditToDoView) {
            if let item = selectedItem {
                EditToDoView(editingToDo: $viewModel.showingEditToDoView, userId: viewModel.userId, item: item)
                    .presentationDetents([.height(400)])
            }
            else {
                Text("No Folder Selected")
            }
        }
        .preferredColorScheme(.dark)
        .padding(.top, 10)
//        .onAppear {
//            print("Loaded items: \(items.count)")
//            print(self.folderId)
//        }
    }
}

#Preview {
    SelectListFolderView(userId: "l8wJsuQJQOgkfqthTgWaMWKkJl43",
                         folderId: "default",
                         folderName: "Reminders",
                         listId: "0")
}
