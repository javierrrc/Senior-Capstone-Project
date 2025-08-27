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
class ScheduleListViewViewModel: ObservableObject{
    @Published var showingNewScheduleView = false
    
    @Published var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete to do list item
    /// - Parameter id: Item id to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("events")
            .document(id)
            .delete()
    }
}
