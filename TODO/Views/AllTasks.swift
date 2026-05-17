//
//  ContentView.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI
import SwiftData


struct AllTasks: View {
    @Query var tasks: [TodoItem]
    
    var groupedByDay: [TaskSection] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        let grouped = Dictionary(grouping: tasks) { item in
            Calendar.current.startOfDay(for: item.dueDate)
        }
        return grouped.sorted(by:{$0.key < $1.key}).map { item in
            TaskSection(title: formatter.string(from: item.key), items: item.value)
        }
        
    }
    
    var body: some View {
        
        TaskPageView(title: "All", sections: groupedByDay)
        
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    AllTasks()
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
