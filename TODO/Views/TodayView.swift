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
    @AppStorage("showCompleted") private var showCompleted:Bool = true
    
    var groupingMode: GroupingMode {
        get { GroupingMode(rawValue: groupingModeRaw) ?? .byDate }
        set { groupingModeRaw = newValue.rawValue }
    }
    
    var grupedByDay: [TaskSection] {
        let today: [TodoItem] = tasks.filter {
            return Calendar.current.isDateInToday($0.dueDate)
        }
        
        let noComplited = today.filter { !$0.isCompleted && !$0.isPinned }.sorted {$0.priority.sortValue > $1.priority.sortValue}
        let complited = today.filter { $0.isCompleted }.sorted{$0.priority.sortValue > $1.priority.sortValue}
        let pinned = today
            .filter { $0.isPinned && !$0.isCompleted }
            .sorted { $0.priority.sortValue > $1.priority.sortValue }
        
        var taskSections : [TaskSection] = [
            TaskSection(title: "Not completed", items: noComplited),
        ]
        
        if !pinned.isEmpty {
            taskSections.insert(TaskSection(title: "Pinned", items: pinned), at: 0)
        }
        
        if showCompleted {
            taskSections.append(TaskSection(title: "Completed", items: complited))
        }
        
        return taskSections
    }
    
    var groupedByCategory: [TaskSection] {
        let today: [TodoItem] = tasks.filter {
            return Calendar.current.isDateInToday($0.dueDate)
        }
        
        func isVisible(_ task: TodoItem) -> Bool {
            showCompleted || !task.isCompleted
        }
        
        let noPinned = today.filter { !$0.isPinned && isVisible($0) }
        let pinned = today.filter{ $0.isPinned && isVisible($0) }.sorted{$0.priority.sortValue > $1.priority.sortValue}
        
        let grouped = Dictionary(grouping: noPinned) { item in
            item.icon
        }
        
        let sections = grouped.sorted(by: {$0.key.sortValue < $1.key.sortValue}).map{(icon, items) in
            TaskSection(title: icon.label, items: items.sorted{$0.priority.sortValue > $1.priority.sortValue})
        }
        
        if(pinned.isEmpty){
            return sections
        }
        return [TaskSection(title: "Pinned", items: pinned)] + sections
        
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
