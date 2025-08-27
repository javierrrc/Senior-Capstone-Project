//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import SwiftUI
import FirebaseFirestore

struct ScheduleListItemView: View {
    @StateObject var viewModel = ScheduleListItemViewModel()
    let task: ScheduleItem
    var userId: String
    @FirestoreQuery var items: [ToDoListItem]
    
    init(task: ScheduleItem, userId: String) {
        self.task = task
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/todos",
            predicates: [.whereField("listId", isEqualTo: task.id),
                         .orderBy("dueDate", false)])
        self.userId = userId
    }
    
    var body: some View {
        HStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    if task.isDone {
                        Text(task.title)
                            .font(.headline)
                            .strikethrough()
                            .foregroundColor(Color.white)
                        HStack(spacing: 0) {
                            Text("\(Date(timeIntervalSince1970: task.startTime).formatted(date: .omitted, time: .shortened))"
                                 + " ~ "
                                 + "\(Date(timeIntervalSince1970: task.endTime).formatted(date: .omitted, time: .shortened))")
                                .font(.footnote)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding(.trailing, 3)
                                .strikethrough()
                            Spacer()
                        }
                    } else {
                        Text(task.title)
                            .font(.headline)
                            .foregroundColor(Color.white)
                        HStack(spacing: 0) {
                            Text("\(Date(timeIntervalSince1970: task.startTime).formatted(date: .omitted, time: .shortened))"
                                 + " ~ "
                                 + "\(Date(timeIntervalSince1970: task.endTime).formatted(date: .omitted, time: .shortened))")
                                .font(.footnote)
                                .foregroundColor(Color(.secondaryLabel))
                                .padding(.trailing, 3)
                            Spacer()
                        }
                    }
                }
                Spacer()
                if !items.isEmpty {
                    Text("\(items.count)")
                        .padding(.horizontal, 15)
                        .frame(height: 30)
                        .font(.headline)
                        .background(Color.blue)
                        .clipShape(.circle)
                        .foregroundColor(Color.primary)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
            .padding()
            .background(Color.theme.darkBackground)
            .clipShape(.rect(cornerRadius: 15))
            Spacer()
            
            Button {
                viewModel.toggleIsDone(item: task)
            } label: {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.white)
            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
}

#Preview {
    ScheduleListItemView(task: .init(id: "123",
                                 title: "capstone",
                                     startTime: Date().timeIntervalSince1970,
                                     endTime: Date().timeIntervalSince1970,
                                     createdDate: Date().timeIntervalSince1970,
                                     repeated: [false, false, false, false, false, false ,false],
                                     isDone: false), userId: "X0Ye1p4l3UYhmT8zemc0Z7YTBkz2")
}

//let id: String
//let title: String
//let day: String
//let startTime: TimeInterval
//let endTime: TimeInterval
//let createdDate: TimeInterval
//let repeated: [Bool]
//var isDone: Bool
