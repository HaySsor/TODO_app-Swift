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
                DatePicker("Select date", selection: $dueDate)
                Picker("Priority", selection: $priority) {
                    ForEach(TaskPriority.allCases, id: \.self){ prio in
                        Text(prio.label).tag(prio)
                    }
                }.pickerStyle(.segmented)
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
        priority: .constant(.low)
    )
}
