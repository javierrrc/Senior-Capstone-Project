//
//  NewItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct NewScheduleView: View {
    @StateObject var viewModel = NewScheduleViewViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
//            Text ("New Item")
//                .font(.system(size: 32))
//                .bold()
//                .padding(.top, 100)
            
            
            NavigationView {
                Form {
                    //Title
                    TextField("Add Title", text: $viewModel.title)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .padding(.bottom)
                        .padding(.top)
                        .font(.headline)
                    //Date
                    MultiDatePicker("Dates", selection: $viewModel.dates)
                    //Start time
                    DatePicker("Start Time", selection: $viewModel.startTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                    //End time
                    DatePicker("End Time", selection: $viewModel.endTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                    //Repeat this event
//                    NavigationLink (destination: RepeatView(viewModel: self.viewModel)) {
//                        HStack {
//                            Text("Repeat")
//                            Spacer()
//                            Text("test")
//                                .foregroundColor(.gray)
//                        }
//                    }
                    //Save button
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
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            newItemPresented = false
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.secondary)
                        })
                    }
                    ToolbarItem(placement: .principal) {
                        Text("New Schedule Block")
                            .bold()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            if viewModel.canSave {
                                viewModel.save()
                                newItemPresented = false
                            } else {
                                viewModel.showAlert = true
                            }
                        }, label: {
                            Text("Save")
                                .foregroundColor(.secondary)
                        })
                    }
                }
            }
//            .onAppear {
//                if viewModel.dates.isEmpty {
//                    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//                    viewModel.dates = [today]
//                }
//            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields and select an end time that is after the start time"))
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NewScheduleView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
}
