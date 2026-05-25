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
    
    
    init(title: String, note: String? = nil, icon: TaskIcon = .work, dueDate: Date = Date(), priority: TaskPriority = .low, hasTime: Bool = false, hasReminder: Bool = false, reminderOffset: ReminderOffset = .atTime) {
        self.title = title
        self.note = note
        self.icon = icon
        self.dueDate = dueDate
        self.priority = priority
        self.hasTime = hasTime
        self.hasReminder = hasReminder
        self.reminderOffset = reminderOffset
    }
    
}
