//
//  EditTaskView.swift
//  TODO
//
//  Created by Przemek Hussar on 17/05/2026.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    var task: TodoItem
    @State private var localTitle: String
    @State private var localNote: String?
    @State private var localIcon: TaskIcon
    @State private var localDue: Date
    @State private var localPriority: TaskPriority
    
    @Environment(\.dismiss) private var dismiss
    
    
    init(task: TodoItem) {
        self.task = task
        _localTitle = State(initialValue: task.title)
        _localNote = State(initialValue: task.note)
        _localIcon = State(initialValue: task.icon)
        _localDue = State(initialValue: task.dueDate)
        _localPriority = State(initialValue: task.priority)
    }
    
    var body: some View {
        NavigationStack {
            TaskFormFields(title: $localTitle, note: $localNote, dueDate: $localDue, icon: $localIcon, priority: $localPriority)
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
               
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        task.title = localTitle
                        task.note = localNote
                        task.icon = localIcon
                        task.dueDate = localDue
                        task.priority = localPriority
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let sampleTask = TodoItem(title: "Zakupy", note: "Mleko, chleb, jajka", icon: .food, dueDate: Date())
    return EditTaskView(task: sampleTask)
        .modelContainer(container)
}
