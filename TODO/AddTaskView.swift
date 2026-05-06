//
//  AddTaskView.swift
//  TODO
//
//  Created by Przemek Hussar on 05/05/2026.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var taskColor : TaskColor = .yellow
    @State private var taskIcon : TaskIcon = .star
    
    var onAdd: (TodoItem) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("what needs to be done...", text: $title)
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 120)
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                    ForEach(TaskColor.allCases, id: \.self) { color in
                        SelectableCircle(isSelected: color == taskColor, strokeColor: color.color)
                            .onTapGesture {
                                taskColor = color
                            }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)

                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    ForEach(TaskIcon.allCases, id: \.self) { icon in
                        ZStack {
                            SelectableCircle(isSelected: icon == taskIcon, strokeColor: taskColor.color)
                            Image(systemName: icon.rawValue)
                                .foregroundStyle(.white)
                                .font(.title3)
                        }
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            taskIcon = icon
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newItem = TodoItem(title: title, description: description, icon: taskIcon, color: taskColor)
                        onAdd(newItem)
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                        .tint(.teal)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(onAdd: { item in })
}
