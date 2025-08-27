//
//  RepeatView.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/2/22.
//

import SwiftUI

struct RepeatView: View {
    @ObservedObject var viewModel: NewScheduleViewViewModel
    
    let days = [
            "Every Monday",
            "Every Tuesday",
            "Every Wednesday",
            "Every Thursday",
            "Every Friday",
            "Every Saturday",
            "Every Sunday"
        ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(days.enumerated()), id: \.offset) { index, day in
                    HStack {
                        Text(day)
                        Spacer()
                        Button {
                            viewModel.repeated[index].toggle()
                        } label: {
                            Image(systemName: viewModel.repeated[index] ? "checkmark" : "")
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
            .navigationTitle("Repeat")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    RepeatView(viewModel: NewScheduleViewViewModel())
}
