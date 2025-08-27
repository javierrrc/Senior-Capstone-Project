//
//  ToDoListItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

// ViewModel for single to do list item view (each row in items list)
class TaskItemViewViewModel: ObservableObject{
    
    private var userId: String
    init(userId: String) {
        self.userId = userId
    }
    
    func toggleIsDone(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
