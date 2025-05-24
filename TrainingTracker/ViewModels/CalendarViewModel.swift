//
//  CalendarViewModel 2.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date = Date()
    let calendar = Calendar.current

    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }

    func generateDays(for month: Date) -> [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: month),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))
        else { return [] }

        var days: [Date] = []

        // Find the weekday index for the first day (Sunday = 1, Saturday = 7)
        let weekdayOfFirst = calendar.component(.weekday, from: firstDayOfMonth)

        // Calculate number of leading empty days (e.g., Sunday = 1, so 0; Monday = 2, so 1)
        let leadingEmptyDays = weekdayOfFirst - calendar.firstWeekday
        let emptyDays = (leadingEmptyDays + 7) % 7

        // Append empty placeholders for days before the 1st
        for _ in 0..<emptyDays {
            days.append(Date.distantPast)
        }

        // Append actual dates of the month
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }

        return days
    }
}
