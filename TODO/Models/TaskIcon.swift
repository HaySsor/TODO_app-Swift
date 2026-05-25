//
//  TaskIcon.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
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
    
    var sortValue : Int {
        switch self {
        case .work: return 0
        case .gym: return 1
        case .health: return 2
        case .house: return 3
        case .science: return 4
        case .hobby: return 5
        case .food: return 6
        case .social: return 7
        case .money: return 8
        case .travel : return 9
        }
    }
}
