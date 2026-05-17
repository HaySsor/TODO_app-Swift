//
//  TODOApp.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI
import SwiftData

@main
struct TODOApp: App {
    let container: ModelContainer
    let viewModel: TodoViewModel

    init() {
        let container = try! ModelContainer(for: TodoItem.self)
        self.container = container
        self.viewModel = TodoViewModel(modelContext: container.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(container)
                .environment(viewModel)
        }
    }
}
