//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import Foundation
import SwiftData

class WorkoutLogRepo {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [WorkoutLog] {
        try context.fetch(FetchDescriptor<WorkoutLog>())
    }

    func fetchByDate(_ date: Date) throws -> [WorkoutLog] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return []
        }

        let descriptor = FetchDescriptor<WorkoutLog>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )
        return try context.fetch(descriptor)
    }

    func fetchByWorkout(_ workout: Workout) throws -> [WorkoutLog] {
        let descriptor = FetchDescriptor<WorkoutLog>(
            predicate: #Predicate { $0.workoutCode == workout.code }
        )
        return try context.fetch(descriptor)
    }

    func fetchLatestDateByWorkout() throws -> [String: Date] {
        let logs = try fetchAll()
        let grouped = Dictionary(grouping: logs, by: { $0.workoutCode })
        return grouped.mapValues { logs in
            logs.max(by: { $0.date < $1.date })?.date ?? Date.distantPast
        }
    }

    func insert(_ log: WorkoutLog) throws {
        context.insert(log)
        try context.save()
    }

    func update(_ log: WorkoutLog) throws {
        let code = log.workoutCode
        let start = Calendar.current.startOfDay(for: log.date)
        guard let end = Calendar.current.date(byAdding: .day, value: 1, to: start) else { return }

        let predicate = #Predicate<WorkoutLog> { log in
            log.workoutCode == code &&
            log.date >= start &&
            log.date < end
        }

        let descriptor = FetchDescriptor<WorkoutLog>(predicate: predicate)
        if let existing = try context.fetch(descriptor).first {
            context.delete(existing)
        }

        context.insert(log)
        try context.save()
    }

    func delete(_ log: WorkoutLog) throws {
        context.delete(log)
        try context.save()
    }
    
    func exists(workout: Workout, on date: Date) throws -> Bool {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
            return false
        }

        let descriptor = FetchDescriptor<WorkoutLog>(
            predicate: #Predicate {
                $0.workoutCode == workout.code &&
                $0.date >= startOfDay && $0.date < endOfDay
            }
        )
        return try context.fetch(descriptor).first != nil
    }
    
    func fetchLatestLog(for workout: Workout) throws -> WorkoutLog? {
        let descriptor = FetchDescriptor<WorkoutLog>(
            predicate: #Predicate { $0.workoutCode == workout.code },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return try context.fetch(descriptor).first
    }
    
    func fetchByMonth(_ month: Date) throws -> [WorkoutLog] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
        var components = DateComponents()
        components.month = 1
        guard let endOfMonth = calendar.date(byAdding: components, to: startOfMonth) else {
            return []
        }

        let descriptor = FetchDescriptor<WorkoutLog>(
            predicate: #Predicate {
                $0.date >= startOfMonth && $0.date < endOfMonth
            }
        )
        return try context.fetch(descriptor)
    }
    
}
