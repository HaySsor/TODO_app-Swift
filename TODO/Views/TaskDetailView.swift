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

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {

                VStack(spacing: 12) {
                    Image(systemName: task.icon.rawValue)
                        .font(.system(size: 50))
                        .overlay(alignment: .bottomTrailing) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(task.isCompleted ? .green : .gray)
                                .onTapGesture { task.isCompleted.toggle() }
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
                                .foregroundStyle(.secondary)
                        }
                    }

                    Section("Details") {
                        LabeledContent("Category") {
                            Label(task.icon.label, systemImage: task.icon.rawValue)
                        }
                        LabeledContent("Date", value: task.dueDate.formatted(date: .abbreviated, time: task.hasTime ? .shortened : .omitted))
                        if task.priority != .none {
                            LabeledContent("Priority") {
                                Label(task.priority.label, systemImage: task.priority.rawValue)
                                    .foregroundStyle(.red)
                            }
                        }
                        if task.hasReminder {
                            LabeledContent("Reminder") {
                                Label(task.reminderOffset.label, systemImage: "bell.fill")
                                    .foregroundStyle(.blue)
                            }
                        }
                        LabeledContent("Status", value: task.isCompleted ? "Completed" : "Not completed")
                    }
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
            }

            Button {
                withAnimation {
                    task.isCompleted.toggle()
                }
            } label: {
                Text(task.isCompleted ? "Mark as not done" : "Mark as done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.bottom, 8)
            .tint(task.isCompleted ? .gray : .yellow)
        }
        .background(Color(.systemGroupedBackground))
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
                Button {

                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let sampleTask = TodoItem(title: "Isc na zakupy", note: "Kupic: Mleko, chleb, jajka", icon: .health, dueDate: Date(), priority: .medium, hasReminder: true)
    return NavigationStack {
        TaskDetailView(task: sampleTask)
    }
    .modelContainer(container)
}
