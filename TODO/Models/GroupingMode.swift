//
//  GroupingMode.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//


enum GroupingMode: String, CaseIterable {
    case byDate
    case byCategory
    
    var label: String {
        switch self {
        case .byDate: return "Date"
        case .byCategory: return "Category"
        }
    }
    
}