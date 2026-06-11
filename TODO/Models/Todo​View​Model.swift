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
    
    func togglePin(_ item: TodoItem){
        item.isPinned.toggle()
    }
    
    func toggleTask(_ item: TodoItem){
        item.isCompleted.toggle()
        item.completedDate = item.isCompleted ? Date() : nil
        
        if item.isCompleted && !item.hasSpawnedNext && item.recurrence != .none {
            let nextDate : Date? = Calendar.current.date(byAdding: item.recurrence.component, value: 1, to: item.dueDate)
            
            guard let nextDate = nextDate else { return }
            
            let newItem = TodoItem(copying: item, dueDate: nextDate)
            
            self.addTask(newItem)
            item.hasSpawnedNext = true
        }
    }
}
