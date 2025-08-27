//
//  NewItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewFolderViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var hasDueDate = false
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        //get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newFolder: Folder
        
        //create model
        newFolder = Folder(id: newId, title: title, folderId: newId, createdDate: Date().timeIntervalSince1970)
        
        //save model how
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(uId)
            .collection("folders")
            .document(newId)
            .setData(newFolder.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        return true
    }
}
