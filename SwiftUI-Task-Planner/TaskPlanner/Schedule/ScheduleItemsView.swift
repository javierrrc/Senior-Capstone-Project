//
//  ScheduleItemsView.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/2/16.
//

import FirebaseFirestore
import SwiftUI

struct ScheduleItemsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: ScheduleItemViewModel
    @FirestoreQuery var items: [ToDoListItem]
    private var label: String
    private var listId: String
    private var userId: String

    init(userId: String, label: String, listId: String) {
        self.label = label
        self.listId = listId
        self.userId = userId
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos",
            predicates: [.whereField("listId", isEqualTo: self.listId),
                         .orderBy("dueDate", false),
                         .orderBy("createdDate", false)])
        self._viewModel = StateObject(
            wrappedValue: ScheduleItemViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            //remove todo item from schedule block
                            Button ("Remove") {
                                viewModel.removeFromList(id: item.id)
                            }
                            .tint(Color.orange)
                            //delete todo item
                            Button ("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .preferredColorScheme(.dark)
            .navigationTitle(self.label).font(.subheadline)
            .toolbar {
//                Button {
//                    //action
//                    viewModel.showingNewItemView = true
//                } label: {
//                    Image(systemName: "plus")
//                        .foregroundColor(.primary)
//                }
                Menu {
                    Button {
                        //add a new to do
                        viewModel.showingNewItemView = true
                    } label: {
                        Text("Add new to-do")
                    }
                    Button {
                        //select existed to do
                        viewModel.selectItemView = true
                    } label: {
                        Text("Select existing to-do")
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primary)
                }
                Menu {
                    Button (role: .destructive) {
                        viewModel.deleteEvent(id: listId)
                        dismiss()
                    } label: {
                        Label("Delete Event", systemImage: "trash")
                    }
                    .tint(.red)
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                }

            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                ScheduleNewItemView(newItemPresented: $viewModel.showingNewItemView, listId: self.listId)
                    .presentationDetents([.height(350)])
            }
            .sheet(isPresented: $viewModel.selectItemView) {
                SelectListView(userId: self.userId, selectItemPresented: $viewModel.selectItemView, listId: self.listId)
//                    .presentationDetents([.height(250)])
            }
        }
        
    }
}

#Preview {
    ScheduleItemsView(userId: "yPihVrTpdvT4bpKOCFB92OeqTly2", label: "study hall", listId: "7F2FD632-A61A-4BA8-98DD-5633758EC3C2")
}
