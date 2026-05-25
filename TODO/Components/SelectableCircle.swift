//
//  SelectableCircle.swift
//  TODO
//
//  Created by Przemek Hussar on 06/05/2026.
//

import SwiftUI

struct SelectableCircle: View {
    var isSelected: Bool
    var strokeColor: Color
    
    var body: some View {
        Circle()
            .foregroundStyle(strokeColor)
            .frame(width: 40, height: 40)
            .overlay {
                Circle()
                    .stroke(strokeColor, lineWidth: 3)
                    .padding(-4)
                    .scaleEffect(isSelected ? 1 : 0.8)
                    .opacity(isSelected ? 1 : 0)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
            .animation(.easeInOut(duration: 0.2), value: strokeColor)
    }
}

#Preview {
    SelectableCircle(isSelected: true, strokeColor: Color.blue)
}
