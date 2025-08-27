//
//  ToDoListViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseFirestore
import Foundation

//ViewModel for list of items
//Primary view
class ScheduleItemViewModel: ObservableObject{
    @Published var showingNewItemView = false
    @Published var selectItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete to do list item
    /// - Parameter id: Item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func removeFromList (id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .updateData(["listId": "0"])
    }
    
    func deleteEvent(id: String) {
        resetToDo(listId: id)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("events")
            .document(id)
            .delete()
    }
    
    func resetToDo(listId: String) {
        let db = Firestore.firestore()
        db.collection("users/\(userId)/todos")
            .whereField("listId", isEqualTo: listId)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else {
                    print("Error fetching items:", error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                for document in documents {
                    let item = try? document.data(as: ToDoListItem.self)
                    if var item = item {
                        item.setlistId("0")  // Assign new listId
                        db.collection("users/\(self.userId)/todos")
                            .document(item.id)
                            .setData(item.asDictionary(), merge: true)
                    }
                }
            }
    }
}
