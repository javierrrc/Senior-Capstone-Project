//
//  NewItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct NewFolderView: View {
    @StateObject var viewModel = NewFolderViewViewModel()
    @Binding var newFolderPresented: Bool
    
    var body: some View {
        VStack {
//            Text ("New Item")
//                .font(.system(size: 32))
//                .bold()
//                .padding(.top, 100)
            
            
            Form {
                //Title
                TextField("List Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                //Button
                TLButton(title: "Save", background: .white, titleColor: .black) {
                    if viewModel.canSave {
                        viewModel.save()
                        newFolderPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
            
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select a due date that is today or newer"))
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NewFolderView(newFolderPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
