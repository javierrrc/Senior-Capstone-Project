//
//  NewItemViewViewModel.swift
//  to do list basic
//
//  Created by Javier Chen on 2024/8/27.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class NewScheduleViewViewModel: ObservableObject{
    @Published var title = ""
    @Published var dates: Set<DateComponents> = []
    @Published var startTime = Date()
    @Published var endTime = Date().addingTimeInterval(3600)
    @Published var showAlert = false
    @Published var repeated = [false, false, false, false, false, false, false]
    private let calendar = Calendar.current
    
    init() {}
    
    func save() {
        guard canSave else {
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        for dateComponent in self.dates {
            if let actualDate = calendar.date(from: dateComponent) {
                let adjustedStartTime = merge(date: actualDate, time: startTime)
                let adjustedEndTime = merge(date: actualDate, time: endTime)
                
                let newId = UUID().uuidString
                
                let newEvent = ScheduleItem(
                    id: newId,
                    title: title,
                    startTime: adjustedStartTime.timeIntervalSince1970,
                    endTime: adjustedEndTime.timeIntervalSince1970,
                    createdDate: Date().timeIntervalSince1970,
                    repeated: self.repeated,
                    isDone: false
                )
                
                let db = Firestore.firestore()
                db.collection("users")
                    .document(uId)
                    .collection("events")
                    .document(newId)
                    .setData(newEvent.asDictionary())
            }
        }
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard endTime > startTime else {
            return false
        }
        guard !dates.isEmpty else {
            return false
        }
        
        return true
    }
    
    private func merge(date: Date, time: Date) -> Date {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        return calendar.date(from: DateComponents(
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day,
            hour: timeComponents.hour,
            minute: timeComponents.minute
        )) ?? date
    }
}
