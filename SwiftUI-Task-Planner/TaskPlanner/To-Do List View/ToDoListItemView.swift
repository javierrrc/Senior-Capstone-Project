//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    let item: ToDoListItem
    
    var body: some View {
        HStack {
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }
            .padding(.trailing, 5)
            .foregroundColor(Color.gray)
            
            VStack (alignment: .leading) {
                if item.isDone {
                    Text(item.title)
                        .font(.body)
                        .strikethrough()
                        .foregroundColor(Color.gray)
                        
                    if item.dueDate != 0 {
                        Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .numeric, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(Color(.secondaryLabel))
                            .strikethrough()
                            .foregroundColor(Color.gray)
                    }
                    
                }
                else {
                    Text(item.title)
                        .font(.body)
                    
                    if item.dueDate != 0 {
                        Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .numeric, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(Color(.secondaryLabel))
                    }
                }
            }
            
            Spacer()
            
            

        }
    }
}

#Preview {
    ToDoListItemView(item: .init(id: "123",
                                 listId: "0",
                                 title: "capstone",
                                 dueDate: Date().timeIntervalSince1970,
                                 createdDate: Date().timeIntervalSince1970,
                                 isDone: true,
                                 selected: false,
                                 showInMainList: true,
                                 folderId: ""))
}
