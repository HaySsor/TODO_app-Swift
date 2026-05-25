//
//  File.swift
//  TODO
//
//  Created by Przemek Hussar on 09/05/2026.
//

import SwiftUI
import SwiftData

@Observable
class TodoViewModel {
    var modelContext: ModelContext
    
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
    }
    
    
    func addTask(_ item : TodoItem){
        withAnimation{
            modelContext.insert(item)
        }
    }
    
    func deleteTask(_ item : TodoItem){
            modelContext.delete(item)
    }
    
    func toggleTask(_ item: TodoItem){
            item.isCompleted.toggle()
    }
}
