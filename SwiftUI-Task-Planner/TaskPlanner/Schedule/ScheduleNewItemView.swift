//
//  NewItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct ScheduleNewItemView: View {
    @StateObject var viewModel: ScheduleNewItemViewViewModel
    @Binding var newItemPresented: Bool
    
    init(newItemPresented: Binding<Bool>, listId: String) {
        self._newItemPresented = newItemPresented
        self._viewModel = StateObject(
            wrappedValue: ScheduleNewItemViewViewModel(listId: listId)
        )
    }
    
    var body: some View {
        VStack {
            
            Form {
                //Title
                TextField("Task Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                //Choose Due Date or not
                Toggle("Has Due Date", isOn: $viewModel.hasDueDate)
                //Due Date
                if (viewModel.hasDueDate) {
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(.compact)
                }
                Toggle("Show in Main List", isOn: $viewModel.showInMainList)
                
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
    }
}

#Preview {
    ScheduleNewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }), listId: "")
}
