//
//  SelectItemViewViewModel.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/3/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

//ViewModel for list of items
//Primary view
class SelectListViewViewModel: ObservableObject{
    let listId: String
    
    init(listId: String) {
        self.listId = listId
    }
    
    /// Delete to do list item
    /// - Parameter id: Item id to delete
    func delete(id: String) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func toggleSelect(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setSelected(!item.selected)
        
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
    
    func addToEvent(item: ToDoListItem) {
        var itemCopy = item
        itemCopy.setlistId(listId)
        
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
    
    func cancel() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users/\(uid)/todos")
            .whereField("selected", isEqualTo: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    print("Error fetching items:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                for document in documents {
                    let item = try? document.data(as: ToDoListItem.self)
                    if var item = item {
                        item.setSelected(false)  // Unselect the item
                        db.collection("users/\(uid)/todos")
                            .document(item.id)
                            .setData(item.asDictionary(), merge: true)
                    }
                }
            }
    }
    
    func save() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users/\(uid)/todos")
            .whereField("selected", isEqualTo: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    print("Error fetching items:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                for document in documents {
                    let item = try? document.data(as: ToDoListItem.self)
                    if var item = item {
                        item.setlistId(self.listId)  // Assign new listId
                        db.collection("users/\(uid)/todos")
                            .document(item.id)
                            .setData(item.asDictionary(), merge: true)
                        
                        // Toggle selection off
                        item.setSelected(false)
                        db.collection("users/\(uid)/todos")
                            .document(item.id)
                            .setData(item.asDictionary(), merge: true)
                    }
                }
            }
    }
}
