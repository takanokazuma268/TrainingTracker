//
//  WorkoutLogViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import Foundation
import SwiftData
import SwiftUI

final class AnalysisViewModel: ObservableObject {

    private var workoutRepo: WorkoutLogRepo?

    @Published var totalWeightGraphData: [(label: String, value: Double)] = []
    @Published var oneRepMaxGraphData: [(label: String, value: Double)] = []

    var totalWeightGraphRange: (min: Double, max: Double) {
        let values = totalWeightGraphData.map { $0.value }
        return (values.min() ?? 0, values.max() ?? 0)
    }

    var oneRepMaxGraphRange: (min: Double, max: Double) {
        let values = oneRepMaxGraphData.map { $0.value }
        return (values.min() ?? 0, values.max() ?? 0)
    }

    func setupRepo(context: ModelContext) {
        self.workoutRepo = WorkoutLogRepo(context: context)
    }

    func updateTotalWeightGraph(for workout: Workout, period: PeriodType) {
        guard let repo = workoutRepo else { return }

        let endDate = Date().endOfMonth
        let startDate = Date().startOfMonth

        do {
            let logs = try repo.fetchByWorkout(workout).filter {
                $0.date >= startDate && $0.date <= endDate
            }

            let grouped = Dictionary(grouping: logs) { log in
                period.groupLabel(from: log.date)
            }

            self.totalWeightGraphData = grouped.map { key, logs in
                let values = logs.map { $0.totalWeight }
                return (label: key, value: values.max() ?? 0)
            }.sorted(by: { $0.label < $1.label })

        } catch {
            self.totalWeightGraphData = []
        }
    }

    func updateOneRepMaxGraph(for workout: Workout, period: PeriodType) {
        guard let repo = workoutRepo else { return }

        let endDate = Date().endOfMonth
        let startDate = Date().startOfMonth

        do {
            let logs = try repo.fetchByWorkout(workout).filter {
                $0.date >= startDate && $0.date <= endDate
            }

            let grouped = Dictionary(grouping: logs) { log in
                period.groupLabel(from: log.date)
            }

            self.oneRepMaxGraphData = grouped.map { key, logs in
                let values = logs.map { $0.sets.map { $0.oneRepMax() }.max() ?? 0 }
                return (label: key, value: values.max() ?? 0)
            }.sorted(by: { $0.label < $1.label })

        } catch {
            self.oneRepMaxGraphData = []
        }
    }
}

enum PeriodType: CaseIterable {
    case monthly
    case biweekly
    case daily

    var defaultMonths: Int {
        switch self {
        case .monthly: return 12
        case .biweekly: return 6
        case .daily: return 1
        }
    }

    var displayName: String {
        switch self {
        case .monthly: return "1年"
        case .biweekly: return "6ヶ月"
        case .daily: return "1ヶ月"
        }
    }

    func groupLabel(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        switch self {
        case .monthly:
            formatter.dateFormat = "yyyy/MM"
        case .biweekly:
            let day = Calendar.current.component(.day, from: date)
            let period = day <= 15 ? "前半" : "後半"
            formatter.dateFormat = "yyyy/MM"
            return formatter.string(from: date) + " " + period
        case .daily:
            formatter.dateFormat = "MM/dd"
        }
        return formatter.string(from: date)
    }
}

// MARK: - WorkoutSet One Rep Max Extension
extension WorkoutSet {
    func oneRepMax() -> Double {
        return weight * (1 + Double(reps) / 30.0)
    }
}

extension WorkoutLog {
    var totalWeight: Double {
        sets.reduce(0) { $0 + ($1.weight * Double($1.reps)) }
    }
}
