//
//  LoginViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMsg = "" 
    
    init() {}
    
    func login() {
        guard login() else {
            return
        }
        
        //Try log in
        
    }
    
    private func login() -> Bool {
        errorMsg = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMsg = "Please fill in all fields"
            
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMsg = "Please enter a valid email"
            return false
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {(authResult, error) in
            if error != nil {
                self.errorMsg = "Invalid Email or Password"
            }
            else {
                print("Login Successful")
            }
        }
        if errorMsg == "" {
            return true;
        }
        else {
            return false; 
        }
    }
    
    
}
