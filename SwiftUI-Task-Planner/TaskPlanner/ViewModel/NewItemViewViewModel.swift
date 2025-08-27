//
//  NewItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewItemViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var hasDueDate = false
    @Published var folderId = "default"
    
    init() {
        
    }
    
    func save() {
        guard canSave else {
            return
        }
        
        //get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newItem: ToDoListItem
        
        //create model
        if (hasDueDate == false) {
            newItem = ToDoListItem(id: newId, listId: "0",
                                   title: title,
                                   dueDate: 0,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false,
                                   selected: false,
                                   showInMainList: true,
                                   folderId: self.folderId)
        }
        else {
            newItem = ToDoListItem(id: newId, listId: "0",
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
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
            .document(newId)
            .setData(newItem.asDictionary())
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
}
