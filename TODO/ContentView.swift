//
//  ContentView.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI



struct ContentView: View {
    
    @State private var newTask: String = ""
    @State private var showAddTask: Bool = false
    
    @State private var toDoList: [TodoItem] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(toDoList.enumerated(), id: \.element.id) {index, item in
                        TodoItemRow(item: item, onToggle: {
                            withAnimation {
                                toDoList[index].isCompleted.toggle()
                            }
                        })
                    }.onDelete(perform: {indexSet in
                        withAnimation{
                            toDoList.remove(atOffsets: indexSet)
                        }
                    })
                }.listStyle(.insetGrouped)
                 .scrollContentBackground(.hidden)
                 

            }.background(Color(.systemGroupedBackground))
                .navigationTitle("To Do List")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddTask.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.teal)
                    }
                }
                .sheet(isPresented: $showAddTask) {
                    AddTaskView { item in
                        withAnimation {
                            toDoList.append(item)
                        }
                    }
                    
                }
               
        }
       
        
    }
}

#Preview {
    ContentView()
}
