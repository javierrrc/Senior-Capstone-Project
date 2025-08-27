//
//  LoginView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                //HeaderView(title: "To do list", subtitle: "Haaland sucks", angle: 15, background: .pink)
                Text("Sign In")
                    .font(.system(size: 50))
                    .bold()
                
                // Login Form
                Form {
                    if !viewModel.errorMsg.isEmpty {
                        Text(viewModel.errorMsg)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Account", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButton(title: "Login", background: .black) {
                        //Attempt to login
                        viewModel.login()
                    }
                    
                }
                
                
                // Create Account
                VStack {
                    Text("Don't have an account?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 30)
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    LoginView()
}
