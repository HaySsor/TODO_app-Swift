//
//  RecurrenceRule.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//

import SwiftUI
import SwiftData



enum RecurrenceRule: String, CaseIterable, Codable{
    
    case none
    case daily
    case weekly
    case monthly
    case yearly 
    
    var label: String {
        switch self {
        case .none: return "Never"
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        }
    }
    
    var component: Calendar.Component {
        switch self {
        case .none: return .day
        case .daily: return .day
        case .weekly: return .weekOfYear
        case .monthly: return .month
        case .yearly: return .year
        }
    }
}

