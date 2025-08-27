//
//  NewItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI
import FirebaseFirestore

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewViewModel()
    @Binding var newItemPresented: Bool
    @FirestoreQuery var folders: [Folder]
    var userId: String
    
    init(newItemPresented: Binding<Bool>, userId: String) {
        self._folders = FirestoreQuery(
            collectionPath: "users/\(userId)/folders",
            predicates: [.orderBy("createdDate", false)])
        self.userId = userId
        self._newItemPresented = newItemPresented
    }
    
    var body: some View {
        VStack {
//            Text ("New Item")
//                .font(.system(size: 32))
//                .bold()
//                .padding(.top, 100)
            
            
            Form {
                //Title
                TextField("Task Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                //Add to list
                Picker("Folder", selection: $viewModel.folderId) {
                    ForEach(folders) { folder in
                        Text(folder.title).tag(folder.folderId)
                    }
                }
                //Choose Due Date or not
                Toggle("Has Due Date", isOn: $viewModel.hasDueDate)
                //Due Date
                if (viewModel.hasDueDate) {
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(.compact)
                }
                
                //Button
                TLButton(title: "Save", background: .white, titleColor: .black) {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
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
        .onAppear {
            if let first = folders.first {
                viewModel.folderId = first.id
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }), userId: "yPihVrTpdvT4bpKOCFB92OeqTly2")
}
