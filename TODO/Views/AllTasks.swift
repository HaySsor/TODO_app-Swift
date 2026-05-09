//
//  ContentView.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI



struct ContentView: View {
    @Environment(TodoViewModel.self) private var viewModel
    
    @State private var showAddTask: Bool = false
    
    
    var body: some View {
        
        
       
        
    }
}

#Preview {
    ContentView()
        .environment(TodoViewModel())
}
