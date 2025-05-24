//
//  WorkoutCalendarGrid.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import SwiftUI

struct WorkoutCalendarGrid: View {
    @ObservedObject var vm: CalendarViewModel
    let workouts: [WorkoutLog]
    let onDateSelected: (Date) -> Void

    var body: some View {
        let days = vm.generateDays(for: vm.currentMonth)
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            let weekdaySymbols = vm.calendar.shortWeekdaySymbols
            let firstWeekdayIndex = vm.calendar.firstWeekday - 1
            let orderedWeekdays = Array(weekdaySymbols[firstWeekdayIndex...] + weekdaySymbols[..<firstWeekdayIndex])
            ForEach(orderedWeekdays, id: \.self) { day in
                Text(day)
                    .foregroundColor(.yellow)
                    .font(.caption)
            }

            ForEach(days, id: \.self) { date in
                let hasWorkout = workouts.contains { vm.calendar.isDate($0.date, inSameDayAs: date) }
                let isSelected = vm.calendar.isDate(date, inSameDayAs: vm.selectedDate)

                Text(date == Date.distantPast ? "" : "\(vm.calendar.component(.day, from: date))")
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(
                        ZStack {
                            if isSelected {
                                Circle().fill(Color.yellow)
                            } else if hasWorkout {
                                Circle().stroke(Color.yellow, lineWidth: 1)
                            }
                        }
                    )
                    .foregroundColor(isSelected ? .black : .white)
                    .onTapGesture {
                        onDateSelected(date)
                    }
            }
        }
        .padding(.horizontal)
    }
}
