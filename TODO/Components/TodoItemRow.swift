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
        
        VStack{
            NavigationLink {
                TaskDetailView(task: item)
            } label: {
                VStack(alignment:.leading, spacing: 10){
                    HStack(spacing: 10){
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title2 )
                            .foregroundStyle(.yellow)
                            .onTapGesture {
                                onToggle()
                            }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 2) {
                                Image(systemName: item.icon.rawValue)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                
                                
                                Text(item.title)
                                    .strikethrough(item.isCompleted)
                                    .foregroundStyle(item.isCompleted ? .gray : .primary)
                                    .font(.headline)
                                    .lineLimit(1)
                                
                            }
                            
                            HStack {
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
                    }
                    

                        
                        
                        HStack {
                            
                            HStack(spacing: 10){
                                
                                Image(systemName: "repeat")
                                    .font(.subheadline)
                                    .foregroundStyle(item.recurrence != .none ? .green : .gray.opacity(0.3))
                                
                                
                                
                                Image(systemName: "bell")
                                    .font(.subheadline)
                                    .foregroundStyle(item.hasReminder ? .blue : .gray.opacity(0.3))
                                
                                
                                Image(systemName: item.priority != .none ? item.priority.rawValue : "exclamationmark")
                                    .font(.subheadline)
                                    .foregroundStyle(item.priority != .none ? .red : .gray.opacity(0.3))
                                
                            }
                            
                            
                            Spacer()
                            
                            if !item.subtasks.isEmpty {
                                HStack{
                                    Image(systemName: "checklist")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    
                                    ProgressView(
                                        value: Double(item.subtasks.filter { $0.isCompleted }.count),
                                        total: Double(item.subtasks.count)
                                    )
                                    .frame(width: 60)
                                    
                                    Text("\(item.subtasks.filter { $0.isCompleted }.count) of \(item.subtasks.count)")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                            
                        }
                    }
                    
                
                
            }
            
        }
        .frame(maxWidth: .infinity)
        
    }
}



#Preview {
    NavigationStack {
        TodoItemRow(item: TodoItem(title: "Przykładowe zadanie", note: "Przykladowy opis", icon: .work, dueDate: Calendar.current.date(bySettingHour: 10, minute: 30, second: 0, of: Date())!, hasReminder: false, recurrence: .none, subtasks: [
            Subtask(title: "Subtask 1", isCompleted: true),
            Subtask(title: "Subtask 2", isCompleted: false)
        ], isPinned: true), onToggle: { })
    }
}
