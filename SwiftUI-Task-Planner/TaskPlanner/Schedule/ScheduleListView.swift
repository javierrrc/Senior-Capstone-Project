//
//  ToDoListItemView.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//

import FirebaseFirestore
import SwiftUI
import UniformTypeIdentifiers

struct ScheduleListView: View {
    @StateObject var viewModel: ScheduleListViewViewModel
    @FirestoreQuery var items: [ScheduleItem]
    @Binding var day: Date
    
    private let calendar: Calendar
    private let startDate: Date
    private let endOfDate: Date
    private let userId: String
    private let db = Firestore.firestore()
    
    init(userId: String, day: Binding<Date>) {
        self._day = day
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: ScheduleListViewViewModel(userId: userId))
        self.calendar = Calendar.current
        self.startDate = calendar.startOfDay(for: day.wrappedValue)
        self.endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/events",
            predicates: [.orderBy("startTime", false),
                         .whereField("startTime", isGreaterThanOrEqualTo: startDate.timeIntervalSince1970),
                         .whereField("startTime", isLessThanOrEqualTo: endOfDate.timeIntervalSince1970)]
        )
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(items) { item in
                        VStack {
                            NavigationLink {
                                ScheduleItemsView(userId: viewModel.userId,
                                                  label: item.title,
                                                  listId: item.id)
                            } label: {
                                ScheduleListItemView(task: item, userId: viewModel.userId)
                            }
                            
                        }
                        
                    }
                }
                .preferredColorScheme(.dark)
            }
            .padding(.top, 15)
            .onAppear() {
                $items.predicates = [.orderBy("startTime", false),
                                     .whereField("startTime", isGreaterThanOrEqualTo: startDate.timeIntervalSince1970),
                                     .whereField("startTime", isLessThanOrEqualTo: endOfDate.timeIntervalSince1970)]
            }
            .onChange(of: day) {
                $items.predicates = [.orderBy("startTime", false),
                                     .whereField("startTime", isGreaterThanOrEqualTo: startDate.timeIntervalSince1970),
                                     .whereField("startTime", isLessThanOrEqualTo: endOfDate.timeIntervalSince1970)]
            }
        }
        
    }
    
}


#Preview {
    ScheduleListView(userId: "ZUTKhHLv7ENXFcGygaC6nqY2fLo2", day: Binding<Date>.constant(Date()))
}
