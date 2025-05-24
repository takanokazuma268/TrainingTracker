//
//  MuscleFatiguePagerViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import Foundation
import SwiftData
import SwiftUI

class MuscleFatiguePagerViewModel: ObservableObject {
    @Published var fatigueDataList: [FatigueInfo] = []
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }

    /// Calculates fatigue info from workout logs
    func createData() {
        print("Starting calculation of muscle fatigue from logs...")

        let latestLogs = getLatestLogsGroupedByWorkoutCode()
        
        let lastUsedByCategory = getLastWorkoutDateByMainCategory(from: latestLogs)
        
        self.fatigueDataList = generateFatigueData(from: lastUsedByCategory)
        for info in fatigueDataList {
            print("部位: \(info.muscleCategory.jaName), 日数差: \(info.difftoday), レベル: \(info.level)")
        }
    }
    
    private func generateFatigueData(from lastUsedByCategory: [MainMuscleCategory: Date]) -> [FatigueInfo] {
        var fatigueData: [FatigueInfo] = []

        for category in MuscleCategory.all {
            let lastDate = lastUsedByCategory[category]
            let diff = lastDate != nil ? Calendar.current.dateComponents([.day], from: lastDate!, to: Date.now).day ?? 0 : -1
            let level: FatigueLevel
            if diff == 0 || diff == 1 {
                level = .high
            } else if diff == 2 {
                level = .low
            } else {
                continue
            }
            let info = FatigueInfo(
                muscleCategory: category,
                difftoday: diff,
                level: level
            )
            fatigueData.append(info)
        }

        return fatigueData
    }
    
    private func getLatestLogsGroupedByWorkoutCode() -> [WorkoutLog] {
        guard let modelContext = modelContext else { return [] }

        let descriptor = FetchDescriptor<WorkoutLog>()
        var latestLogs: [WorkoutLog] = []

        do {
            let logs = try modelContext.fetch(descriptor)
            let grouped = Dictionary(grouping: logs, by: { $0.workoutCode })
            print("Fetched logs count: \(logs.count)")
            for (_, logs) in grouped {
                if let latest = logs.max(by: { $0.date < $1.date }) {
                    latestLogs.append(latest)
                }
            }
            for log in latestLogs {
                print("Latest workoutCode: \(log.workoutCode), date: \(log.date)")
            }
        } catch {
            print("Failed to fetch logs: \(error)")
        }

        return latestLogs
    }
    
    private func getLastWorkoutDateByMainCategory(from logs: [WorkoutLog]) -> [MainMuscleCategory: Date] {
        var result: [MainMuscleCategory: Date] = [:]

        for log in logs {
            if let category = log.category {
                for main in category.mainCategories {
                    if let existing = result[main] {
                        result[main] = max(existing, log.date)
                    } else {
                        result[main] = log.date
                    }
                }
            }
        }

        return result
    }
}

struct FatigueInfo : Identifiable{
    var id: String {
        "\(muscleCategory.code)-\(difftoday)"
    }
    let muscleCategory: MainMuscleCategory
    let difftoday: Int
    let level: FatigueLevel
}
