//
//  TaskSection.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//
import SwiftUI
import SwiftData

struct TaskSection: Identifiable, Equatable {
    var id: String {
        title
    }
    var title: String
    var items: [TodoItem]
}
