//
//  AddTaskView.swift
//  TODO
//
//  Created by Przemek Hussar on 05/05/2026.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("categoryDefault") private var categoryDefaultRaw: String = TaskIcon.work.rawValue
    
    @State private var title: String = ""
    @State private var note: String?
    @State private var taskIcon : TaskIcon
    @State private var dueDate: Date = Date()
    @State private var priority: TaskPriority = .none
    @State private var hasTime: Bool = false
    @State private var hasReminder: Bool = false
    @State private var reminderOffset : ReminderOffset = .tenMin
    @State private var recurrence: RecurrenceRule = .none
    
    init(onAdd : @escaping (TodoItem) -> Void) {
        self.onAdd = onAdd
        let defValue = UserDefaults.standard.string(forKey: "categoryDefault") ?? TaskIcon.work.rawValue
        _taskIcon = State(initialValue: TaskIcon(rawValue: defValue) ?? .work)
    }
    
    var onAdd: (TodoItem) -> Void
    
    var body: some View {
        NavigationStack {
            TaskFormFields(title: $title, note: $note, dueDate: $dueDate, icon: $taskIcon, priority: $priority, hasTime: $hasTime, hasReminder: $hasReminder, reminderOffset: $reminderOffset, recurrence: $recurrence)
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newItem = TodoItem(title: title, note: note, icon: taskIcon, dueDate: dueDate, priority: priority, hasTime: hasTime, hasReminder: hasReminder, reminderOffset: reminderOffset, recurrence: recurrence)
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
