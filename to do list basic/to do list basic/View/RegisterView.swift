//
//  RegisterView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()

    
    var body: some View {
        VStack {
            // Header
            //HeaderView(title: "Register", subtitle: "doku's a scrub", angle: -15, background: .orange)
            Text("Register")
                .font(.system(size: 50))
                .bold()
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(title: "Create Account", background: .black) {
                    viewModel.register()
                }
                
            }
            
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
