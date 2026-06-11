//
//  TodoItem.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//
import SwiftUI
import SwiftData

@Model
class TodoItem: Equatable {
    @Relationship(deleteRule:.cascade, inverse: \Subtask.parent)
    
    var id: UUID = UUID()
    var title : String
    var isCompleted: Bool = false
    var note: String?
    var icon: TaskIcon
    var dueDate: Date
    var priority: TaskPriority
    var hasTime: Bool
    var hasReminder: Bool
    var reminderOffset: ReminderOffset
    var recurrence: RecurrenceRule = RecurrenceRule.none
    var hasSpawnedNext: Bool = false
    var subtasks: [Subtask] = []
    var isPinned: Bool = false
    var completedDate: Date? = nil
    
    
    init(title: String, note: String? = nil, icon: TaskIcon = .work, dueDate: Date = Date(), priority: TaskPriority = .low, hasTime: Bool = false, hasReminder: Bool = false, reminderOffset: ReminderOffset = .atTime, recurrence: RecurrenceRule = .none, subtasks: [Subtask] = [] , isPinned: Bool = false, completedDate: Date? = nil) {
        self.title = title
        self.note = note
        self.icon = icon
        self.dueDate = dueDate
        self.priority = priority
        self.hasTime = hasTime
        self.hasReminder = hasReminder
        self.reminderOffset = reminderOffset
        self.recurrence = recurrence
        self.subtasks = subtasks
        self.isPinned = isPinned
        self.completedDate = completedDate
    }
    
    convenience init(copying other: TodoItem, dueDate: Date) {
        self.init(
            title: other.title,
            note: other.note,
            icon: other.icon,
            dueDate: dueDate,
            priority: other.priority,
            hasTime: other.hasTime,
            hasReminder: other.hasReminder,
            reminderOffset: other.reminderOffset,
            recurrence: other.recurrence
        )
    }
    
}
