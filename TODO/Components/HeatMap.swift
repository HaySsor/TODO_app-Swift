//
//  HeatMap.swift
//  TODO
//
//  Created by Przemek Hussar on 02/06/2026.
//

import SwiftUI

struct HeatMap: View {
    var completedTasks: [Date: Int]

    @Binding var currentMonth: Date
    
    @State private var slideEdge: Edge = .trailing
    @State private var oppositeEdge : Edge = .leading

    var monthLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth)
    }

    let columns = [
        GridItem(.adaptive(minimum: 20))
    ]

    var days: Range<Int>? {
        Calendar.current.range(of: .day, in: .month, for: currentMonth)
    }

    var dayCount: Int {
        days?.count ?? 30
    }

    func count(for dayNumber: Int) -> Int {
        let cal = Calendar.current
        let comps = cal.dateComponents([.year, .month], from: currentMonth)
        guard let year = comps.year, let month = comps.month,
              let date = cal.date(from: DateComponents(year: year, month: month, day: dayNumber)) else {
            return 0
        }
        return completedTasks[date] ?? 0
    }

    func opacityFor(_ count: Int) -> Double {
        switch count {
        case 0: return 0.15
        case 1: return 0.35
        case 2...3: return 0.6
        default: return 1.0
        }
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left.circle.fill")
                    .font(.title)
                    .onTapGesture {
                        slideEdge = .leading
                        oppositeEdge = .trailing
                        withAnimation {
                            currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? Date()
                        }
                        
                    }
                Spacer()
                Text(monthLabel)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .id(currentMonth)
                    .transition(.asymmetric(
                        insertion: .move(edge: slideEdge).combined(with: .opacity),
                        removal: .move(edge: oppositeEdge).combined(with: .opacity)
                    ))
                
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title)
                    .onTapGesture {
                        slideEdge = .trailing
                        oppositeEdge = .leading
                        withAnimation {
                            currentMonth = Calendar.current.date(byAdding: .month, value: +1, to: currentMonth) ?? Date()
                        }
                    }
            }

            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(1...dayCount, id: \.self) { dayNumber in
                    let dayCount = count(for: dayNumber)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(dayCount > 0
                            ? Color.yellow.opacity(opacityFor(dayCount))
                            : Color.gray.opacity(0.1))
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding()
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    let cal = Calendar.current
    let today = Date()
    let comps = cal.dateComponents([.year, .month], from: today)

    func day(_ n: Int) -> Date {
        cal.date(from: DateComponents(year: comps.year, month: comps.month, day: n))!
    }

    let sample: [Date: Int] = [
        day(1): 1,
        day(3): 2,
        day(5): 4,
        day(7): 1,
        day(10): 3,
        day(12): 5,
        day(15): 2,
        day(18): 1,
        day(20): 6,
        day(22): 3,
        day(25): 1
    ]

    return HeatMap(completedTasks: sample, currentMonth: .constant(Date()))
        .padding()
}
