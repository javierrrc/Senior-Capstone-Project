//
//  ToDoListItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

// ViewModel for single schedule list item view (each row in schedule list)
class ScheduleListItemViewModel: ObservableObject{
    init() {}
    
    func toggleIsDone(item: ScheduleItem) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("events")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary()) { error in
                if let error = error {
                    print("Error updating isDone: \(error)")
                }
            }
    }
}
