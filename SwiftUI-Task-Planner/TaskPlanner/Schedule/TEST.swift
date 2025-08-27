//
//  TEST.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/6/26.
//

import SwiftUI

struct TEST: View {
    @State private var users = ["Glenn", "Malcolm", "Nicola", "Terri"]
    
    var body: some View {
        NavigationStack {
            List($users, id: \.self, editActions: .all) { $user in
                Text(user)
            }
            .toolbar{
                EditButton()
            }
        }
    }
}

#Preview {
    TEST()
}
