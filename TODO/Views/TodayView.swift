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
    @AppStorage("groupingMode") private var groupingModeRaw: String = GroupingMode.byDate.rawValue
    
    var groupingMode: GroupingMode {
        get { GroupingMode(rawValue: groupingModeRaw) ?? .byDate }
        set { groupingModeRaw = newValue.rawValue }
    }
    
    var grupedByDay: [TaskSection] {
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
    
    var groupedByCategory: [TaskSection] {
        let today: [TodoItem] = tasks.filter {
            return Calendar.current.isDateInToday($0.dueDate)
        }
        
        let grouped = Dictionary(grouping: today) { item in
            item.icon
        }
        
        return grouped.sorted(by: {$0.key.sortValue < $1.key.sortValue}).map{(icon, items) in
            TaskSection(title: icon.label, items: items.sorted{$0.priority.sortValue > $1.priority.sortValue})
        }
        
    }
    
    var section: [TaskSection]{
        switch groupingMode{
        case .byDate: return grupedByDay
        case .byCategory: return groupedByCategory
        }
    }
    
    var body: some View {
        TaskPageView(title:"Today", sections: section)
            
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    TodayView()
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
