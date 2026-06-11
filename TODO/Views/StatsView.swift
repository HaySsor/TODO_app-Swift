//
//  StatsView.swift
//  TODO
//
//  Created by Przemek Hussar on 02/06/2026.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Query var tasks: [TodoItem]
    
    @State private var currentMonth: Date = Date()
    
    var filtered: [TodoItem]  {
        tasks.filter { $0.isCompleted }
    }
    
    var complitedTasks: [Date: Int] {
        let grouped = Dictionary(grouping: filtered) { item in
            Calendar.current.startOfDay(for: item.completedDate ?? item.dueDate)
        }

        return grouped.mapValues { $0.count }
    }
    
    var monthComplited: Int {
       let taskInCurrentMonth = filtered.filter { task in
           guard let completed = task.completedDate else { return false }
           return Calendar.current.isDate(completed, equalTo: currentMonth, toGranularity: .month)
       }
        
        return taskInCurrentMonth.count
    }
    
    var todayComplited: Int {
        let today = Date()
        
        let taskToday = filtered.filter{task in
            guard let completed = task.completedDate else { return false }
            return Calendar.current.isDate(completed, equalTo: today, toGranularity: .day)
        }
        
        return taskToday.count
    }
    
    var tasksByCategoryThisMonth: [TaskIcon: Int] {
       let allTaskInMonth = tasks.filter { task in
           return Calendar.current.isDate(task.dueDate, equalTo: currentMonth, toGranularity: .month)
        }
        
        let grouped = Dictionary(grouping: allTaskInMonth) { $0.icon }
        
        return grouped.mapValues{$0.count}
    }
    
    var completedByCategoryThisMonth: [TaskIcon: Int] {
       let allComplitedTaskInThisMonth = filtered.filter { task in
           guard let completed = task.completedDate else { return false }
           return Calendar.current.isDate(completed, equalTo: currentMonth, toGranularity: .month)
        }
        
        let grouped = Dictionary(grouping: allComplitedTaskInThisMonth) { $0.icon }
        
        return grouped.mapValues{$0.count}
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    HeatMap(completedTasks: complitedTasks, currentMonth: $currentMonth)
                    
                    HStack(spacing: 20 ){
                        StatBox(title: "Total Complited", value: monthComplited, backgroundColor: .black, fontColor: .white)
                        StatBox(title: "Today Complited", value: todayComplited, backgroundColor: .white, fontColor: .black)
                    }
                    
                    if(!tasks.isEmpty) {
                        CategoryChart(
                            taskByCategory: tasksByCategoryThisMonth,
                            completedByCategory: completedByCategoryThisMonth
                        )
                        .frame(height: 250)
                    }
                    
                    
                }
                
                
            }
            .navigationTitle("Stats")
            .padding(16)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    StatsView()
}
