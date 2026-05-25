//
//  TaskSection.swift
//  TODO
//
//  Created by Przemek Hussar on 25/05/2026.
//


struct TaskSection: Identifiable, Equatable {
    var id: String {
        title
    }
    var title: String
    var items: [TodoItem]
}
