//
//  ReminderOffset.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//


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