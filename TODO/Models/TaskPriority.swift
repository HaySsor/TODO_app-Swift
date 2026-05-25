//
//  TaskPriority.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//


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