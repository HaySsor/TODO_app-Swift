//
//  TaskFormFields.swift
//  TODO
//
//  Created by Przemek Hussar on 17/05/2026.
//

import SwiftUI

struct TaskFormFields: View {
    @Binding var title: String
    @Binding var note: String?
    @Binding var dueDate: Date
    @Binding var icon: TaskIcon
    @Binding var priority: TaskPriority
    @Binding var hasTime: Bool
    @Binding var hasReminder: Bool
    @Binding var reminderOffset: ReminderOffset
    @Binding var recurrence: RecurrenceRule
    
    
    var body: some View {
        Form {
            Section("Category"){
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 20){
                        ForEach(TaskIcon.allCases, id: \.self) { icon in
                            VStack{
                                ZStack {
                                    SelectableCircle(isSelected: icon == self.icon, strokeColor: .black)
                                    Image(systemName: icon.rawValue)
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                    
                                }
                                .frame(width: 40, height: 40)
                                Text(icon.label)
                                    .font(.caption2)
                                    .padding(.top, 5)
                            }.onTapGesture {
                                self.icon = icon
                            }
                            
                        }
                    }.padding(.top, 10)
                        .padding(.leading, 10)
                        .padding(.horizontal, 10)
                }
            }
            
            Section("Title*") {
                TextField("what needs to be done...", text: $title)
            }
            
            Section("Description") {
                TextEditor(text: Binding(
                    get: { self.note ?? "" },
                    set: { self.note = $0.isEmpty ? nil : $0 }
                ))
                .frame(height: 120)
            }

            Section("Details"){
                Picker("Priority", selection: $priority) {
                    ForEach(TaskPriority.allCases, id: \.self){ prio in
                        Text(prio.label).tag(prio)
                    }
                }.pickerStyle(.segmented)
                Toggle("Include time", isOn: $hasTime.animation())
                    .onChange(of: hasTime) {oldValue, newValue in
                        if !newValue {
                            hasReminder = false
                        }
                    }
                if hasTime {
                    DatePicker("Select date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                } else {
                    DatePicker("Select date", selection: $dueDate, displayedComponents: .date)
                }
                if hasTime {
                    Toggle("Add reminder", isOn: $hasReminder.animation())
                    if hasReminder {
                        Picker("Reminder", selection: $reminderOffset) {
                            ForEach(ReminderOffset.allCases, id: \.self){ offset in
                                Text(offset.label).tag(offset)
                            }
                        }.pickerStyle(.automatic)
                    }
                }
                Picker("Recurring", selection: $recurrence){
                    ForEach(RecurrenceRule.allCases, id: \.self) { rule in
                        Text(rule.label).tag(rule)
                    }
                }
            }
            
        }
    }
}

#Preview {
    TaskFormFields(
        title: .constant("Zakupy"),
        note: .constant("Mleko, chleb, jajka"),
        dueDate: .constant(Date()),
        icon: .constant(.work),
        priority: .constant(.low),
        hasTime: .constant(false),
        hasReminder: .constant(true),
        reminderOffset: .constant(.tenMin),
        recurrence: .constant(.daily)
    )
}
