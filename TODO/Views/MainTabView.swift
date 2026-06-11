//
//  MainTabView.swift
//  TODO
//
//  Created by Przemek Hussar on 09/05/2026.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Today")
                }
            AllTasks()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("All")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Stats")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
            
        }
        .tint(.black)
    }
}

#Preview {
    let container = try! ModelContainer(for: TodoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    MainTabView()
        .modelContainer(container)
        .environment(TodoViewModel(modelContext: container.mainContext))
}
