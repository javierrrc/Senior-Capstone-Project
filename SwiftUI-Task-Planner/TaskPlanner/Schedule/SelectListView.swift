//
//  SelectItemView.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/3/23.
//

import FirebaseFirestore
import SwiftUI

struct SelectListView: View {
    @StateObject var viewModel: SelectListViewViewModel
//    @FirestoreQuery var items: [ToDoListItem]
    @FirestoreQuery var folders: [Folder]
    @Binding var selectItemPresented: Bool
    private var listId: String
    private var userId: String

    init(userId: String, selectItemPresented: Binding<Bool>, listId: String) {
        self._selectItemPresented = selectItemPresented
        self._folders = FirestoreQuery(
            collectionPath: "users/\(userId)/folders",
            predicates: [.orderBy("createdDate", false)])
//        self._items = FirestoreQuery(
//            collectionPath: "users/\(userId)/todos",
//            predicates: [.orderBy("dueDate", false),
//                         .orderBy("createdDate", false),
//                         .whereField("isDone", isEqualTo: false),
//                         .whereField("listId", isEqualTo: "0")])
        self._viewModel = StateObject(
            wrappedValue: SelectListViewViewModel(listId: listId)
        )
        self.listId = listId
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(folders) { folder in
                        SelectListFolderView(userId: self.userId,
                                             folderId: folder.folderId,
                                             folderName: folder.title,
                                             listId: self.listId)
                            
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.2))
                    }
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        viewModel.cancel()
                        selectItemPresented = false
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.secondary)
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        viewModel.save()
                        selectItemPresented = false
                    }, label: {
                        Text("Add")
                            .foregroundColor(.secondary)
                    })
                }
            }
        }
        
    }
}

#Preview {
    SelectListView(userId: "yPihVrTpdvT4bpKOCFB92OeqTly2",
                   selectItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }), listId: "")
}
