//
//  StatBox.swift
//  TODO
//
//  Created by Przemek Hussar on 04/06/2026.
//

import SwiftUI

struct StatBox: View {
    
    var title : String
    var value : Int
    var backgroundColor: Color
    var fontColor: Color
    
    
    var body: some View {
        VStack{
            Text(title)
                .font(.headline)
                .foregroundStyle(fontColor)
            
            Text("\(value)")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundStyle(fontColor)
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    StatBox(
        title:"Total Complited",
        value: 10,
        backgroundColor: .black,
        fontColor: .white
    )
}
 
