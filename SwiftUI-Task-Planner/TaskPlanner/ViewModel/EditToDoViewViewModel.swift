//
//  NewItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditToDoViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var hasDueDate = false
    @Published var folderId = "default"
    
    init(item: ToDoListItem) {
        self.title = item.title
        self.dueDate = Date(timeIntervalSince1970: item.dueDate)
        if self.dueDate.timeIntervalSince1970 > 0 {
            hasDueDate = true
        }
        self.folderId = item.folderId
    }
    
    func save(item: ToDoListItem) {
        guard canSave else {
            return
        }
        
        //get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let id = item.id
        let editedItem: ToDoListItem
        
        //create model
        if (hasDueDate == false) {
            editedItem = ToDoListItem(id: id, listId: "0",
                                      title: title,
                                      dueDate: 0,
                                      createdDate: Date().timeIntervalSince1970,
                                      isDone: false,
                                      selected: false,
                                      showInMainList: true,
                                      folderId: self.folderId)
        }
        else {
            editedItem = ToDoListItem(id: id, listId: "0",
                                      title: title,
                                      dueDate: self.dueDate.timeIntervalSince1970,
                                      createdDate: Date().timeIntervalSince1970,
                                      isDone: false,
                                      selected: false,
                                      showInMainList: true,
                                      folderId: self.folderId)
        }
        
        //save model how
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(id)
                .setData(editedItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
//        guard dueDate >= Date().addingTimeInterval(-86400) else {
//            return false
//        }
        
        return true
    }
    
    func deleteItem(item: ToDoListItem) {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let id = item.id
        
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
