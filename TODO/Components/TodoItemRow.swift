//
//  TodoItemRow.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI

struct TodoItemRow: View {
    var item: TodoItem
    var onToggle: () -> Void
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: item.dueDate)
    }
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(.yellow)
                .onTapGesture {
                    onToggle()
                }
            Divider().frame(height: 30)
                .background(.gray)
            if item.priority != .none || item.hasReminder {
                VStack(spacing: 10){
                    if item.priority != .none {
                        Image(systemName: item.priority.rawValue)
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    }
                    if item.hasReminder {
                        Image(systemName: "bell")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                }
                
                Divider().frame(height: 30)
                    .background(.gray)
            }
            
            
            NavigationLink {
                TaskDetailView(task: item)
            } label: {
                HStack(spacing: 12) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 4) {
                            Image(systemName: item.icon.rawValue)
                                .font(.headline)
                                .foregroundStyle(.black)
                            
                            
                            Text(item.title)
                                .strikethrough(item.isCompleted)
                                .foregroundStyle(item.isCompleted ? .gray : .primary)
                                .font(.headline)
                                .lineLimit(1)
                            
                        }
                        
                        HStack(spacing: 4) {
                            if item.hasTime {
                                Text(formattedTime)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                            }
                            if item.hasTime && item.note != nil {
                                Text("·")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            
                            if let note = item.note, !note.isEmpty {
                                Text(note)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
            }
        }
        .contentShape(Rectangle())
    }
}



#Preview {
    NavigationStack {
        TodoItemRow(item: TodoItem(title: "Przykładowe zadanie", note: "Przykladowy opis", icon: .work, dueDate: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!, hasReminder: true), onToggle: { })
    }
}
