//
//  TodoItem.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI
import SwiftData


enum TaskIcon: String, CaseIterable, Codable {
    case work = "briefcase"
    case gym = "dumbbell"
    case health = "heart"
    case house = "house"
    case science = "book.pages"
    case hobby = "paintbrush"
    case food = "cart"
    case social = "person.2"
    case money = "creditcard"
    case travel = "airplane"
    
    var label: String {
        switch self {
        case .work: return "Work"
        case .gym: return "Sport"
        case .health: return "Health"
        case .house: return "Home"
        case .science: return "Study"
        case .hobby: return "Hobby"
        case .food: return "Food"
        case .social: return "Social"
        case .money: return "Finance"
        case .travel: return "Travel"
        }
    }
}

enum TaskPriority: String, CaseIterable, Codable {
    case none = "-"
    case low = "exclamationmark"
    case medium = "exclamationmark.2"
    case high = "exclamationmark.3"
    
    var label: String {
        switch self {
        case .none: return "No Prio"
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
    
    var sortValue : Int {
        switch self {
        case .none: return 0
        case .low: return 1
        case .medium: return 2
        case .high: return 3
        }
    }
}

enum ReminderOffset: Int, CaseIterable, Codable {
    case atTime = 0
    case tenMin = 10
    case thirtyMin = 30
    case oneHour = 60
    case twoHours = 120
    case oneDay = 1440
    
    var label: String {
        switch self {
        case .atTime: return "At Time"
        case .tenMin: return "10 min"
        case .thirtyMin: return "30 min"
        case .oneHour: return "1 hour"
        case .twoHours: return "2 hours"
        case .oneDay: return "1 day"
        }
    }
}


struct TaskSection: Identifiable, Equatable {
    var id: String {
        title
    }
    var title: String
    var items: [TodoItem]
}


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
