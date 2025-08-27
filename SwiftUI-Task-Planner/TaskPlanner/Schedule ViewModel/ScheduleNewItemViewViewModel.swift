//
//  NewItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class ScheduleNewItemViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var listId: String
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var showInMainList = true
    @Published var hasDueDate: Bool = false
    
    init(listId: String) {
        self.listId = listId
    }
    
    func save() {
        guard canSave else {
            return
        }
        
        //get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        //create model
        let newId = UUID().uuidString
        let newItem: ToDoListItem
        
        //create model
        if (hasDueDate == false) {
            newItem = ToDoListItem(id: newId, listId: self.listId,
                                   title: title,
                                   dueDate: 0,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false,
                                   selected: false,
                                   showInMainList: self.showInMainList,
                                   folderId: "default")
        }
        else {
            newItem = ToDoListItem(id: newId, listId: self.listId,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false,
                                   selected: false,
                                   showInMainList: self.showInMainList,
                                   folderId: "default")
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
