//
//  TodayView.swift
//  TODO
//
//  Created by Przemek Hussar on 12/05/2026.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    @Query var tasks : [TodoItem]
    
    var grupedByStatus: [TaskSection] {
        let today: [TodoItem] = tasks.filter {
            return Calendar.current.isDateInToday($0.dueDate)
        }
        
        let noComplited = today.filter { !$0.isCompleted }.sorted {$0.priority.sortValue > $1.priority.sortValue}
        let complited = today.filter { $0.isCompleted }.sorted{$0.priority.sortValue > $1.priority.sortValue}
        
        return [
            TaskSection(title: "Not completed", items: noComplited),
            TaskSection(title: "Completed", items: complited)
        ]
    }
    
    var body: some View {
        
        TaskPageView(title:"Today", sections: grupedByStatus)
       
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    TodayView()
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
