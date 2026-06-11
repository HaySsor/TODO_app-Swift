//
//  TaskDetailView.swift
//  TODO
//
//  Created by Przemek Hussar on 24/05/2026.
//

import SwiftUI
import SwiftData


struct TaskDetailView: View {
    var task: TodoItem
    
    @Environment(TodoViewModel.self) var viewModel
    @Environment(\.dismiss) private var dismiss

    @AppStorage("confirmDelete") private var confirmDelete: Bool = false

    @State private var isEditing: Bool = false
    @State private var showCheck: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    var doneIcon: String {
        return task.isCompleted ? "xmark.circle" : "checkmark.circle.fill"
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                VStack(spacing: 12) {
                    Image(systemName: showCheck ? doneIcon : task.icon.rawValue)
                        .font(.system(size: 60))
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                        .overlay(alignment: .bottomTrailing) {
                            if task.isCompleted && !showCheck {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title3)
                                    .foregroundStyle(.green)
                                    .transition(.scale.combined(with: .opacity))
                            }
                            
                        }
                    
                    Text(task.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                List {
                    if let note = task.note, !note.isEmpty {
                        Section("Notes") {
                            Text(note)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                        }
                    }
                    
                    SubtasksSection(task: task)
                    
                    Section("Details") {
                        HStack {
                            Image(systemName: "list.bullet.circle")
                            Text("Category")
                            Spacer()
                            Text(task.icon.label).foregroundStyle(.secondary)
                        }
                        HStack {
                            Image(systemName: "calendar")
                            Text("Date")
                            Spacer()
                            Text(task.dueDate.formatted(date: .abbreviated, time: task.hasTime ? .shortened : .omitted))
                                .foregroundStyle(.secondary)
                        }
                        if task.priority != .none {
                            HStack {
                                Image(systemName: "exclamationmark.circle")
                                Text("Priority")
                                Spacer()
                                Image(systemName: task.priority.rawValue).foregroundStyle(.red)
                                Text(task.priority.label).foregroundStyle(.secondary)
                            }
                        }
                        if task.hasReminder {
                            HStack {
                                Image(systemName: "bell")
                                Text("Reminder")
                                Spacer()
                                Text(task.reminderOffset.label).foregroundStyle(.secondary)
                            }
                        }
                        if task.recurrence != .none {
                            HStack {
                                Image(systemName: "repeat")
                                Text("Recurrence")
                                Spacer()
                                Text(task.recurrence.label).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }.padding(.bottom, 80)
            
            Button {
                Task {
                    withAnimation { showCheck = true }
                    try? await Task.sleep(for: .seconds(1))
                    withAnimation {
                        viewModel.toggleTask(task)
                        if task.isCompleted {
                            task.subtasks.forEach{ $0.isCompleted = true}
                        }
                    }
                    withAnimation { showCheck = false }
                    
                }
            } label: {
                Text(task.isCompleted ? "Mark as not done" : "Mark as done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.bottom, 20)
            .tint(task.isCompleted ? .gray : .yellow)
        }
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button{
                    withAnimation {
                        viewModel.togglePin(task)
                    }
                   
                }label: {
                    Image(systemName: task.isPinned ? "pin" : "pin.slash")
                        .foregroundStyle(task.isPinned ? .yellow : .black)
                        .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                }
                
                Button {
                    if confirmDelete {
                        showDeleteAlert = true
                    } else {
                        viewModel.deleteTask(task)
                        dismiss()
                    }
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
                Button {
                    withAnimation {
                        isEditing.toggle()
                    }
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditTaskView(task: task)
        }
        .alert("Delete task?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteTask(task)
                dismiss()
            }
        } message: {
            Text("'\(task.title)' will be permanently deleted.")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let sampleTask = TodoItem(title: "Isc na zakupy", note: "Kupic: Mleko, chleb, jajka", icon: .money, dueDate: Date(), priority: .medium, hasReminder: true, recurrence: .monthly)
    return NavigationStack {
        TaskDetailView(task: sampleTask)
    }
    .modelContainer(container)
    .environment(TodoViewModel(modelContext: container.mainContext))
}
