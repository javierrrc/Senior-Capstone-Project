//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI

struct SelectListItemView: View {
    @StateObject var viewModel: SelectListViewViewModel
    @State private var selected = false
    let item: ToDoListItem
    
    init(item: ToDoListItem, listId: String) {
        self.item = item
        self._viewModel = StateObject(
            wrappedValue: SelectListViewViewModel(listId: listId)
        )
    }
    
    var body: some View {
        HStack {
            Button {
                viewModel.toggleSelect(item: item)
            } label: {
                Image(systemName: item.selected ? "checkmark.square.fill" : "square")
            }
            .padding(.horizontal, 10)
            VStack (alignment: .leading) {
                Text(item.title)
                    .font(.body)
                if item.dueDate != 0 {
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .numeric, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
            
            Spacer()

        }
    }
}

#Preview {
    SelectListItemView(item: .init(id: "123",
                                   listId: "0",
                                   title: "capstone",
                                   dueDate: Date().timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false,
                                   selected: false,
                                   showInMainList: true,
                                   folderId: ""),
                       listId: "0")
}
