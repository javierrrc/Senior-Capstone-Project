//
//  RegisterViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMsg = ""
    
    init() {}
    
    func register() {
        guard validate () else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
        let newId = UUID().uuidString
        let newFolder: Folder
        
        //create model
        newFolder = Folder(id: newId, title: "Reminders", folderId: "default", createdDate: 0)
        
        db.collection("users")
            .document(id)
            .collection("folders")
            .document(newId)
            .setData(newFolder.asDictionary())
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMsg = "All fields are required"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMsg = "Invalid email format"
            return false
        }
        guard password.count >= 6 else {
            errorMsg = "Password must be at least 6 characters long"
            return false
        }
        return true
    }
}
