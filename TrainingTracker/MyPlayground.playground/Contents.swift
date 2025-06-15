import UIKit

var greeting = CalendarModel(month: Date())
print(greeting)

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
        let calendar = Calendar.current

        guard let range = calendar.range(of: .day, in: .month, for: month),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) else {
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
        return (weekday - calendar.firstWeekday + 7) % 7
    }
}
