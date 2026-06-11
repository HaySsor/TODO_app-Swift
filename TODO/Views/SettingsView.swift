//
//  SettingsView.swift
//  TODO
//
//  Created by Przemek Hussar on 09/06/2026.
//

import SwiftUI
import SwiftData


struct SettingsView: View {
    @AppStorage("groupingMode") private var groupingModeRaw: String = GroupingMode.byDate.rawValue
    @AppStorage("categoryDefault") private var categoryDefaultRaw: String = TaskIcon.work.rawValue
    @AppStorage("showCompleted") private var showCompleted: Bool = true
    @AppStorage("confirmDelete") private var confirmDelete: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isPresented: Bool = false
    
    
    func deleteAll(){
        try? modelContext.delete(model: TodoItem.self)
        try? modelContext.delete(model: Subtask.self)
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Defaults"){
                    
                    Picker(selection: $groupingModeRaw) {
                        ForEach(GroupingMode.allCases, id: \.self){ prio in
                            Text(prio.label).tag(prio.rawValue)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "list.bullet.indent")
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            Text("Default Grouping")
                        }
                    }
                    
                    Picker(selection: $categoryDefaultRaw) {
                        ForEach(TaskIcon.allCases, id: \.self){ prio in
                            Text(prio.label).tag(prio.rawValue)
                        }
                    }label: {
                        HStack {
                            Image(systemName: "folder")
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            Text("Default Category")
                        }
                    }
                }
                
                Section("Behavior"){
                    Toggle(isOn: $showCompleted) {
                        HStack {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            Text("Show Completed Tasks")
                        }
                    }
                    Toggle(isOn: $confirmDelete) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.red)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                            Text("Confirm Before Delete")
                        }
                    }
                }
                
                Section("Data"){
                    HStack{
                        LabeledContent {
                            Button("Reset", role: .destructive) {
                                isPresented = true
                            }.alert("Are you sure?", isPresented: $isPresented) {
                                Button("Cancel", role: .cancel) { }
                                Button("Delete", role: .destructive) {
                                    deleteAll()
                                }
                            } message: {
                                Text("All your tasks will be deleted.")
                            }
                        } label: {
                            Text("Reset All Data")
                            Text("Delete all your tasks")
                        }

                    }
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview {
    SettingsView()
}
