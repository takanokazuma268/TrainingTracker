//
//  P.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/03.
//
import Foundation
import SwiftData

final class ProteinChartViewModel: ObservableObject {
    @Published var weekStartDate: Date = ProteinChartViewModel.calculateWeekStartDate()
    @Published var weeklyTotals: [(date: Date, total: Double)] = []
    @Published var record: [ProteinLog] = []
    private var proteinLogRepo: ProteinLogRepo?
    
    static func calculateWeekStartDate() -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.firstWeekday = 1 // Sunday
        
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let weekday = calendar.component(.weekday, from: startOfToday)
        let daysToSubtract = (weekday + 6) % 7 // Make Sunday = 0, Monday = 1, ..., Saturday = 6
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: startOfToday) ?? startOfToday
    }
    
    var weeklyAverage: Double {
        fetchTotalAmountForWeek() / 7
    }
    
    func setupRepository(with context: ModelContext) {
        self.proteinLogRepo = ProteinLogRepo(context: context)
    }
    
    func shiftWeek(by weeks: Int) {
        if let newDate = Calendar.current.date(byAdding: .day, value: weeks * 7, to: weekStartDate) {
            weekStartDate = newDate
            loadWeeklyTotals()
        }
    }
    
    func weekRangeString() -> String {
        let calendar = Calendar.current
        guard let endDate = calendar.date(byAdding: .day, value: 6, to: self.weekStartDate) else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        return "\(formatter.string(from: self.weekStartDate)) - \(formatter.string(from: endDate))"
    }
    
    func fetchTotalAmountForWeek() -> Double {
        guard let repo = proteinLogRepo else { return 0 }
        let calendar = Calendar.current
        guard let endDate = calendar.date(byAdding: .day, value: 7, to: weekStartDate) else {
            return 0
        }
        do {
            return try repo.totalAmountBetween(startDate: weekStartDate, endDate: endDate)
        } catch {
            print("Error fetching total amount for week: \(error)")
            return 0
        }
    }
    
    func loadWeeklyTotals() {
        let calendar = Calendar.current
        guard let endDate = calendar.date(byAdding: .day, value: 7, to: weekStartDate),
              let repo = proteinLogRepo else {
            return
        }
        do {
            let result = try repo.totalAmountsByDatesInRange(startDate: weekStartDate, endDate: endDate)
            DispatchQueue.main.async {
                self.weeklyTotals = result.map { ($0.date, $0.total ?? 0) }
            }
        } catch {
            print("Error loading weekly totals: \(error)")
        }
    }
    
    func fetchRecordsByDate(_ date: Date) throws {
        guard let repo = proteinLogRepo else {
            self.record = []
            return
        }

        let normalizedDate = Calendar.current.startOfDay(for: date)
        self.record = try repo.fetchByDate(normalizedDate)
    }

    func dailyTotalAmounts(from groupedLogs: [Date: [ProteinLog]]) -> [(date: Date, total: Double)] {
        groupedLogs.map { (date, logs) in
            let total = logs.reduce(0) { $0 + $1.amount }
            return (date, total)
        }
        .sorted { $0.date < $1.date }
    }

    func delete(log: ProteinLog) {
        guard let repo = proteinLogRepo else { return }
        do {
            try repo.delete(log)
            if let index = record.firstIndex(where: { $0.id == log.id }) {
                record.remove(at: index)
            }
            loadWeeklyTotals()
        } catch {
            print("Error deleting log: \(error)")
        }
    }
}
