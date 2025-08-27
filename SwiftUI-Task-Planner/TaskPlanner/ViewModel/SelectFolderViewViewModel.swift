//
//  SelectFolderViewViewModel.swift
//  TaskPlanner
//
//  Created by Javier Chen on 2025/4/10.
//

import Foundation

class SelectFolderViewViewModel: ObservableObject{
    private let userId: String
    @Published var selectedFolderId: String
    
    init(userId: String) {
        self.userId = userId
        self.selectedFolderId = "0"
    }
}
