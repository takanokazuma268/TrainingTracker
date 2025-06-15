//
//  DateExtensions.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/04.
//
import Foundation

extension Date {
    func daysAgo(from date: Date = Date()) -> Int {
        Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0
    }
    
    var timeOnly: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    var weekdayAbbreviation: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    ///月初を取得する
    var startOfMonth: Date {
        let calendar = Calendar.current
        if let start = calendar.date(from: calendar.dateComponents([.year, .month], from: self)),
           let adjustedStart = calendar.date(byAdding: .day, value: 1, to: start) {
            return adjustedStart
        }
        return self
    }

    /// 月末を取得する
    var endOfMonth: Date {
        let calendar = Calendar.current
        if let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)),
           let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: startOfMonth),
           let end = calendar.date(byAdding: DateComponents(second: -1), to: startOfNextMonth) {
            return end
        }
        return self
    }
}
