//
//  TodoItemRow.swift
//  TODO
//
//  Created by Przemek Hussar on 04/05/2026.
//

import SwiftUI

struct TodoItemRow: View {
    var item: TodoItem
    var onToggle: () -> Void
    
    var body: some View{
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(item.color.color)
                Image(systemName: item.icon.rawValue)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            VStack(alignment: .leading){
                Text(item.title)
                    .strikethrough(item.isCompleted)
                    .foregroundStyle(item.isCompleted ? .gray : .primary)
                    .font(.headline)
                    .lineLimit(1)
                
                if !item.description.isEmpty {
                    Text(item.description)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                }
                
            }
            
            Spacer()
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onToggle()
        }
    }
}



#Preview {
    TodoItemRow(item: TodoItem(title: "Przykładowe zadanie",description: "Przykladowy opis", icon: .star, color: .yellow), onToggle: { })
}
