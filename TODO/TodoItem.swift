//
//  TodoItem.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI

enum TaskColor: String, CaseIterable {
    case yellow = "yellow"
    case red = "red"
    case blue = "blue"
    case green = "green"
    
    var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        }
    }
}

enum TaskIcon: String, CaseIterable {
    case star = "star.fill"
    case heart = "heart.fill"
    case book = "book.fill"
    case house = "house.fill"
    case briefcase = "briefcase.fill"
}

struct TodoItem {
    let id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    var description: String = ""
    var icon: TaskIcon = .star
    var color: TaskColor = .yellow
}
