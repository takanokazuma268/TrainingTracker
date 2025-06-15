//
//  ProteinLogRepo.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/02.
//
import Foundation
import SwiftData

class ProteinLogRepo {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [ProteinLog] {
        try context.fetch(FetchDescriptor<ProteinLog>())
    }

    func fetchByDate(_ date: Date) throws -> [ProteinLog] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return []
        }

        let descriptor = FetchDescriptor<ProteinLog>(
            predicate: #Predicate {
                $0.dateTime >= startOfDay && $0.dateTime < endOfDay
            },
            sortBy: [SortDescriptor(\.dateTime, order: .forward)]
        )
        return try context.fetch(descriptor)
    }

    func insert(_ log: ProteinLog) throws {
        context.insert(log)
        try context.save()
    }

    func delete(_ log: ProteinLog) throws {
        context.delete(log)
        try context.save()
    }
    
    func totalAmountByDate(_ date: Date) throws -> Double {
        let logs = try fetchByDate(date)
        return logs.reduce(0) { $0 + $1.amount }
    }
    
    func totalAmountBetween(startDate: Date, endDate: Date) throws -> Double {
        let descriptor = FetchDescriptor<ProteinLog>(
            predicate: #Predicate {
                $0.dateTime >= startDate && $0.dateTime < endDate
            }
        )
        let logs = try context.fetch(descriptor)
        return logs.reduce(0) { $0 + $1.amount }
    }
    
    func totalAmountsByDatesInRange(startDate: Date, endDate: Date) throws -> [(date: Date, total: Double?)] {
        var results: [(date: Date, total: Double?)] = []
        let calendar = Calendar.current
        var currentDate = calendar.startOfDay(for: startDate)
        
        while currentDate < endDate {
            let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            let descriptor = FetchDescriptor<ProteinLog>(
                predicate: #Predicate {
                    $0.dateTime >= currentDate && $0.dateTime < nextDate
                }
            )
            let logs = try context.fetch(descriptor)
            let total = logs.isEmpty ? nil : logs.reduce(0) { $0 + $1.amount }
            results.append((date: currentDate, total: total))
            currentDate = nextDate
        }
        
        return results
    }
}
