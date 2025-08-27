//
//  TaskView.swift
//  TaskPlanner
//
//  Created by Javier Chen on 19/04/2024.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @StateObject var viewModel: TaskViewModel
//    @ObservedObject var weekViewModel = WeekHeaderViewModel()
    @State private var createNewTask: Bool = false
    @State var currentDate: Date = .init()
    
    init(userId: String) {
        self.currentDate = .init()
        self._viewModel = StateObject(
            wrappedValue: TaskViewModel(userId: userId)
        )
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.currentDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    WeekHeaderView(viewModel: viewModel)
                        .frame(height: 89)
                    
                    ScheduleListView(userId: viewModel.userId, day: $viewModel.currentDate)
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text(self.viewModel.currentDate.formatted(.dateTime.month(.wide)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(self.viewModel.currentDate.formatted(.dateTime.year()))
                                .foregroundColor(Color.theme.secondaryText)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            createNewTask = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        })
                            .sheet(isPresented: $createNewTask) {
                                NewScheduleView(newItemPresented: $createNewTask)
//                                    .presentationDetents([.height(250)])
                                    .presentationBackground(.thinMaterial)
                            }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    NavigationView {
        TaskView(userId: "yPihVrTpdvT4bpKOCFB92OeqTly2")
            .modelContainer(for: Task.self)
    }
}
