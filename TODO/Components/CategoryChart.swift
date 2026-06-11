//
//  CategoryChart.swift
//  TODO
//
//  Created by Przemek Hussar on 04/06/2026.
//

import SwiftUI
import Charts

struct CategoryChart: View {

    var taskByCategory: [TaskIcon: Int]
    var completedByCategory: [TaskIcon: Int]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Chart {
                ForEach(taskByCategory.sorted(by: { $0.value > $1.value }), id: \.key) { (icon, count) in
                    // Tło: total (jasny) — annotation nad nim
                    BarMark(
                        x: .value("Category", icon.rawValue),
                        yStart: .value("Start", 0),
                        yEnd: .value("End", count),
                        width: .fixed(40)
                    )
                    .foregroundStyle(.yellow.opacity(0.2))
                    .cornerRadius(6)
                    .annotation(position: .top) {
                        Text("\(count)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }

                    // Wypełnienie: completed (pełny żółty)
                    BarMark(
                        x: .value("Category", icon.rawValue),
                        yStart: .value("Start", 0),
                        yEnd: .value("End", completedByCategory[icon] ?? 0),
                        width: .fixed(40)
                    )
                    .foregroundStyle(.yellow)
                    .cornerRadius(6)
                    .annotation(position: .overlay) {
                        if(completedByCategory[icon] ?? 0) > 0 {
                            Text("\(completedByCategory[icon] ?? 0)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        
                    }
                }
            }
            .chartXAxis {
                AxisMarks { value in
                    AxisValueLabel {
                        if let symbolName = value.as(String.self) {
                            Image(systemName: symbolName)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .chartYAxis(.hidden)
            .frame(width: CGFloat(taskByCategory.count) * 60, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
}

#Preview {
    CategoryChart(
        taskByCategory: [
            .work: 12,
            .gym: 8,
            .health: 5,
            .food: 15,
            .hobby: 3,
            .house: 7,
            .social: 4
        ],
        completedByCategory: [
            .work: 7,
            .gym: 5,
            .health: 2,
            .food: 10,
            .hobby: 1,
            .house: 4,
            .social: 3
        ]
    )
    .frame(height: 250)
    .padding()
}
