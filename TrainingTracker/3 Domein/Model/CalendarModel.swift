//
//  Calendar.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import Foundation

struct CalendarModel : CustomStringConvertible{
    let month: Date
    let days: [Date]

    init(month: Date) {
        self.month = month
        self.days = CalendarModel.generateCalendarDates(for: month)
    }
    
    var description: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"

        let dateList = days
            .filter { $0 != Date.distantPast }
            .map { dayFormatter.string(from: $0) }
            .joined(separator: ", ")

        return """
        月：\(formatter.string(from: month))
        日付一覧：\(dateList)
        """
    }

    private static func generateCalendarDates(for month: Date) -> [Date] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        var components = calendar.dateComponents([.year, .month], from: month)
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0

        guard let firstDayOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return []
        }

        let emptyCount = leadingEmptyDays(for: firstDayOfMonth, calendar: calendar)
        let emptyDays = Array(repeating: Date.distantPast, count: emptyCount)

        let daysInMonth = range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)
        }

        return emptyDays + daysInMonth
    }

    private static func leadingEmptyDays(for firstDayOfMonth: Date, calendar: Calendar) -> Int {
        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
        let adjustedWeekday = weekday - 1  // Makes Sunday = 0, Monday = 1, ..., Saturday = 6
        return adjustedWeekday
    }
    
    func changeMonth(by offset: Int) -> CalendarModel {
        let calendar = Calendar.current
        guard let newMonth = calendar.date(byAdding: .month, value: offset, to: self.month) else {
            return self
        }
        return CalendarModel(month: newMonth)
    }
    
    func formattedMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.string(from: month)
    }
    
    func orderedShortWeekdaySymbols() -> [String] {
        let formatter = DateFormatter()
        guard let symbols = formatter.shortWeekdaySymbols else { return [] }
        
        let firstWeekdayIndex = Calendar.current.firstWeekday - 1
        return Array(symbols[firstWeekdayIndex...] + symbols[..<firstWeekdayIndex])
    }
}
