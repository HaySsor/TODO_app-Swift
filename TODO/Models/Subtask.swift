//
//  Subtask.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//

import SwiftUI
import SwiftData


@Model class Subtask {
    var id:UUID = UUID()
    var title : String
    var isCompleted: Bool = false
    var parent : TodoItem?
    
    init(title: String, isCompleted: Bool = false){
        self.title = title
        self.isCompleted = isCompleted
    }
}
