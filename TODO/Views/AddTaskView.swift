//
//  AddTaskView.swift
//  TODO
//
//  Created by Przemek Hussar on 05/05/2026.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var note: String?
    @State private var taskIcon : TaskIcon = .work
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .none
    @State private var hasTime: Bool = false
    @State private var hasReminder: Bool = false
    @State private var reminderOffset : ReminderOffset = .tenMin
    
    
    var onAdd: (TodoItem) -> Void
    
    var body: some View {
        NavigationStack {
            TaskFormFields(title: $title, note: $note, dueDate: $dueDate, icon: $taskIcon, priority: $priority, hasTime: $hasTime, hasReminder: $hasReminder, reminderOffset: $reminderOffset)
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newItem = TodoItem(title: title, note: note, icon: taskIcon, dueDate: dueDate, priority: priority, hasTime: hasTime, hasReminder: hasReminder, reminderOffset: reminderOffset)
                        onAdd(newItem)
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                        .tint(.black)
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(onAdd: { item in })
}
