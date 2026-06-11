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
    @AppStorage("groupingMode") private var groupingModeRow: String = GroupingMode.byDate.rawValue
    @AppStorage("showCompleted") private var showCompleted: Bool = true
    
    var groupingMode: GroupingMode {
        get {  GroupingMode(rawValue: groupingModeRow) ?? .byDate }
        set { groupingModeRow =  newValue.rawValue}
    }
    
    func isVisible(_ task: TodoItem) -> Bool {
        showCompleted || !task.isCompleted
    }
    
    var pinnedTasks: [TodoItem] {
        tasks.filter { $0.isPinned && isVisible($0) }.sorted {
            if $0.priority.sortValue != $1.priority.sortValue {
                return $0.priority.sortValue > $1.priority.sortValue
            }
            return $0.dueDate < $1.dueDate
        }
    }
    
    var groupedByDay: [TaskSection] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        
        let noPinned = tasks.filter({ !$0.isPinned && isVisible($0) })
        
        let grouped = Dictionary(grouping: noPinned) { item in
            Calendar.current.startOfDay(for: item.dueDate)
        }
        let sections = grouped.sorted(by:{$0.key < $1.key}).map { item in
            TaskSection(title: formatter.string(from: item.key), items: item.value.sorted{$0.priority.sortValue > $1.priority.sortValue})
        }
        
        if(pinnedTasks.isEmpty){
            return sections
        }
        return [TaskSection(title: "Pinned", items: pinnedTasks)] + sections
        
    }
    
    var groupedByCategory: [TaskSection] {
        let noPinned = tasks.filter({ !$0.isPinned && isVisible($0) })
        let grouped = Dictionary(grouping: noPinned) { item in
            item.icon
        }

        let sections = grouped.sorted(by: {$0.key.sortValue < $1.key.sortValue}).map{(icon, items) in
            TaskSection(title: icon.label, items: items.sorted{$0.priority.sortValue > $1.priority.sortValue})
        }
        
        if(pinnedTasks.isEmpty){
            return sections
        }
        
        return [TaskSection(title: "Pinned", items: pinnedTasks)] + sections
    }
    
    var sections: [TaskSection] {
        switch groupingMode {
        case .byDate: return groupedByDay
        case .byCategory: return groupedByCategory
        }
    }
    
    var body: some View {
        TaskPageView(title: "All", sections: sections)
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    AllTasks()
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
