//
//  SubtasksSection.swift
//  TODO
//
//  Created by Przemek Hussar on 29/05/2026.
//

import SwiftUI
import SwiftData

struct SubtasksSection: View {
    
    var task: TodoItem
   
    @Environment(TodoViewModel.self) var viewModel
    
    @State private var isAddingSubtask: Bool = false
    @State private var newSubtaskTitle: String = ""
    @FocusState private var isFieldFocused: Bool
    
    
    func addSubtask() {
        if newSubtaskTitle.trimmingCharacters(in: .whitespaces).isEmpty { return }
        let newSubtask: Subtask = Subtask(title: newSubtaskTitle, isCompleted: false)
        task.subtasks.append(newSubtask)
        
        newSubtaskTitle = ""
        isFieldFocused = false
        isAddingSubtask = false
    }
    
    func deleteSubtask(_ subtask: Subtask) {
        task.subtasks.removeAll{ $0.id == subtask.id }
    }
    
    func updateParentCompletion() {
        if task.subtasks.isEmpty { return }
        
        let allDone = task.subtasks.allSatisfy(\.isCompleted)

        if allDone && !task.isCompleted {
            viewModel.toggleTask(task)
        } else if !allDone && task.isCompleted {
            viewModel.toggleTask(task)
        }
    }
    
    var body: some View {
        
        Section{
            if(!task.subtasks.isEmpty || isAddingSubtask){
                
                ForEach(task.subtasks, id: \.self.id){ subtask in
                    @Bindable var subtask = subtask
                    HStack{
                        HStack{
                            Image(systemName: subtask.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(.green)
                                .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.wholeSymbol), options: .nonRepeating))
                                .onTapGesture {
                                    withAnimation {
                                        subtask.isCompleted.toggle()
                                        updateParentCompletion()
                                    }
                                }
                            
                            TextField("Title", text: $subtask.title)
                                .strikethrough(subtask.isCompleted)
                                .foregroundStyle(subtask.isCompleted ? .gray : .primary)
                                .disabled(subtask.isCompleted)
                        }
                        
                    }
                    .swipeActions {
                        Button(role:.destructive){
                            deleteSubtask(subtask)
                        } label:{
                            Image(systemName: "trash")
                        }
                    }
                }
                
                if isAddingSubtask {
                    HStack {
                        Image(systemName: "circle")
                        TextField("Title...", text:$newSubtaskTitle)
                            .textFieldStyle(.plain)
                            .focused($isFieldFocused)
                            .onSubmit {
                                addSubtask()
                            }
                        
                        Spacer()
                        
                        Button{
                            addSubtask()
                        }label:{
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            
            
            
        } header: {
            HStack {
                Text("Subtasks")
                Spacer()
                Button {
                    withAnimation{
                        isAddingSubtask.toggle()
                        if isAddingSubtask {
                            isFieldFocused = true
                        }
                    }
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(.bordered)
                    .tint(.green)
                
            }
        }
        
    }
}

#Preview {
    @Previewable @State var isAdding = false
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let sampleTask = TodoItem(title: "Zakupy", subtasks: [
        Subtask(title: "Mleko", isCompleted: false),
        Subtask(title: "Chleb", isCompleted: true)
    ])

    List {
        SubtasksSection(task: sampleTask)
    }
    .modelContainer(container)
    .environment(TodoViewModel(modelContext: container.mainContext))
}
