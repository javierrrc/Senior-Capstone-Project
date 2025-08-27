//
//  RepeatView.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/2/22.
//

import SwiftUI
import FirebaseFirestore

struct SelectFolderView: View {
    @StateObject var viewModel: SelectFolderViewViewModel
    @FirestoreQuery var folders: [Folder]
    var userId: String
    
    init(userId: String) {
        self._folders = FirestoreQuery(
            collectionPath: "users/\(userId)/folders")
        self._viewModel = StateObject(
            wrappedValue: SelectFolderViewViewModel(userId: userId)
        )
        self.userId = userId
    }
    
    var body: some View {
        NavigationView {
            List {
                Picker("Folder", selection: $viewModel.selectedFolderId) {
                    ForEach(folders, id: \.self) { folder in
                        Text(folder.title)
                    }
                }
            }
            .navigationTitle("Repeat")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    SelectFolderView(userId: "")
}
