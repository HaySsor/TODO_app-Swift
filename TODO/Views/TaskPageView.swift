//
//  TaskPageView.swift
//  TODO
//
//  Created by Przemek Hussar on 10/05/2026.
//

import SwiftUI
import SwiftData

struct TaskPageView: View {
    @AppStorage("groupingMode") private var groupingModeRaw: String = GroupingMode.byDate.rawValue
    
    var groupingMode: GroupingMode {
        get { GroupingMode(rawValue: groupingModeRaw) ?? .byDate }
        set { groupingModeRaw = newValue.rawValue }
    }
    
    var title: String
    var sections: [TaskSection]
    @Environment(TodoViewModel.self) var viewModel
    
    @State private var showAddTask: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottomTrailing){
                
                List{
                    ForEach(sections) { section in
                        Section(section.title){
                            ForEach(section.items) { item in
                                TodoItemRow(item: item, onToggle: {
                                    viewModel.toggleTask(item)
                                })
                                .swipeActions {
                                    Button(role: .destructive) {
                                        viewModel.deleteTask(item)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                        }
                    }
                }.listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .animation(.default, value: sections)
                
                Button{
                    showAddTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .tint(.white)
                        .frame(width: 50, height: 50)
                        .font(.title)
                    
                }.buttonStyle(.borderedProminent)
                    .tint(.black)
                    .clipShape(Circle())
                    .padding(.horizontal, 20)
                    .padding(.bottom , 20)
                
            }.background(Color(.systemGroupedBackground))
                .navigationTitle("\(title)")
                .navigationBarTitleDisplayMode(.large)
                .toolbar{
                    Menu {
                        Picker("Group by", selection: $groupingModeRaw) {
                            ForEach(GroupingMode.allCases, id: \.self) { mode in
                                Text(mode.label).tag(mode.rawValue)
                            }
                        }
                    } label: {
                        Image(systemName: groupingMode == .byDate ? "calendar" : "list.bullet.circle")
                            .foregroundStyle( groupingMode == .byDate ? .black : .yellow )
                    }
                }
            
                .sheet(isPresented: $showAddTask) {
                    AddTaskView { item in
                        viewModel.addTask(item)
                    }
                    
                }
            
        }
        
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    TaskPageView(title: "All", sections: [])
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
