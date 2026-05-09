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

                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    ForEach(TaskIcon.allCases, id: \.self) { icon in
                        ZStack {
                            SelectableCircle(isSelected: icon == taskIcon, strokeColor: .black)
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
                        let newItem = TodoItem(title: title, description: description, icon: taskIcon)
                        onAdd(newItem)
                        dismiss()
                    }.buttonStyle(.borderedProminent)
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(onAdd: { item in })
}
