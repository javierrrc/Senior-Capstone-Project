//
//  NewItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI
import FirebaseFirestore

struct EditToDoView: View {
    @StateObject var viewModel: EditToDoViewViewModel
    @Binding var editingToDo: Bool
    @FirestoreQuery var folders: [Folder]
    var userId: String
    var item: ToDoListItem
    
    init(editingToDo: Binding<Bool>, userId: String, item: ToDoListItem) {
        self._folders = FirestoreQuery(
            collectionPath: "users/\(userId)/folders",
            predicates: [.orderBy("createdDate", false)])
        self.userId = userId
        self._editingToDo = editingToDo
        self.item = item
        self._viewModel = StateObject(wrappedValue: EditToDoViewViewModel(item: item))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                //            Text ("New Item")
                //                .font(.system(size: 32))
                //                .bold()
                //                .padding(.top, 100)
                
                
                Form {
                    //Title
                    TextField("Task Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                    //Add to list
                    Picker("Folder", selection: $viewModel.folderId) {
                        ForEach(folders) { folder in
                            Text(folder.title).tag(folder.folderId)
                        }
                    }
                    //Choose Due Date or not
                    Toggle("Has Due Date", isOn: $viewModel.hasDueDate)
                    //Due Date
                    if (viewModel.hasDueDate) {
                        DatePicker("Due Date", selection: $viewModel.dueDate)
                            .datePickerStyle(.compact)
                    }
                    
                    //Button
                    TLButton(title: "Save", background: .white, titleColor: .black) {
                        if viewModel.canSave {
                            viewModel.save(item: self.item)
                            editingToDo = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            viewModel.deleteItem(item: self.item)
                            editingToDo = false
                        }, label: {
                            Text("Delete Item")
                                .foregroundColor(Color.red)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.save(item: self.item)
                            editingToDo = false
                        } label: {
                            Text("Save")
                                .foregroundColor(Color.blue)
                        }
                        
                    }
                }
                
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields and select a due date that is today or newer"))
                }
            }
            .preferredColorScheme(.dark)
            .onAppear {
                if let first = folders.first {
                    viewModel.folderId = first.id
                }
            }
        }
    }
}

#Preview {
    EditToDoView(editingToDo: Binding(get: {
        return true
    }, set: { _ in
        
    }), userId: "yPihVrTpdvT4bpKOCFB92OeqTly2", item: .init(id: "123",
                                                            listId: "0",
                                                            title: "capstone",
                                                            dueDate: Date().timeIntervalSince1970,
                                                            createdDate: Date().timeIntervalSince1970,
                                                            isDone: false,
                                                            selected: false,
                                                            showInMainList: true,
                                                            folderId: ""))
}
