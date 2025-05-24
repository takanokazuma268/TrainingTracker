//
//  WorkoutLogViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import Foundation
import SwiftData
import SwiftUI

final class WorkoutLogViewModel: ObservableObject {
    let workoutCategory: WorkoutCategory
    @Published var workoutDate: Date = Date()
    @Published var sets: [WorkoutInputRow] = [
        WorkoutInputRow(set: 1),
        WorkoutInputRow(set: 2),
        WorkoutInputRow(set: 3)
    ]
    @Published var isHomeView: Bool = false
    @Published var showOverwriteAlert = false
    @Published var existingLogToReplace: WorkoutLog?
    @Published var showInputErrorAlert = false
    @Binding var path: [Path]
    var modelContext: ModelContext?
    
    init(workoutCategory: WorkoutCategory, date: Date? = nil, modelContext: ModelContext?, path: Binding<[Path]>) {
        self.workoutCategory = workoutCategory
        self.workoutDate = date ?? Date()
        self.modelContext = modelContext
        self._path = path
        print("📝 WorkoutLogViewModel initialized with category: \(workoutCategory.code), date: \(self.workoutDate)")
    }

    func handleSave() {
        guard isValidInput() else {
            showInputErrorAlert = true
            return
        }

        if let existing = checkForOverwrite() {
            existingLogToReplace = existing
            showOverwriteAlert = true
            return
        }

        saveWorkout()
    }

    func isValidInput() -> Bool {
        sets.contains { Double($0.weight) != nil && Int($0.reps) != nil }
    }

    func checkForOverwrite() -> WorkoutLog? {
        guard let modelContext = modelContext else { return nil }
        do {
            let logs = try modelContext.fetch(FetchDescriptor<WorkoutLog>())
            return logs.first {
                $0.workoutCode == workoutCategory.code &&
                Calendar.current.isDate($0.date, inSameDayAs: workoutDate)
            }
        } catch {
            print("❌ Failed to fetch logs: \(error)")
            return nil
        }
    }

    func saveWorkout(replacing existing: WorkoutLog? = nil) {
        guard let modelContext = modelContext else { return }
        if let existing = existing {
            modelContext.delete(existing)
        }

        let savedSets = sets.compactMap { row -> WorkoutSet? in
            guard let weight = Double(row.weight),
                  let reps = Int(row.reps) else {
                return nil
            }
            return WorkoutSet(setNumber: row.set, weight: weight, reps: reps)
        }

        let newLog = WorkoutLog(workoutCode: workoutCategory.code, date: workoutDate, sets: savedSets)
        modelContext.insert(newLog)

        do {
            try modelContext.save()
            path.removeAll()
        } catch {
            print("❌ Failed to save workout: \(error)")
        }
    }

    func loadLatestWorkoutIfExists() {
        guard let modelContext = modelContext else { return }
        Task {
            do {
                let logs = try modelContext.fetch(FetchDescriptor<WorkoutLog>())
                if let existing = logs.first(where: {
                    $0.workoutCode == workoutCategory.code &&
                    Calendar.current.isDate($0.date, inSameDayAs: workoutDate)
                }) {
                    DispatchQueue.main.async {
                        self.sets = existing.sets
                            .sorted(by: { $0.setNumber < $1.setNumber })
                            .map {
                                WorkoutInputRow(set: $0.setNumber, weight: String($0.weight), reps: String($0.reps))
                            }
                    }
                }
            } catch {
                print("❌ WorkoutLogの取得に失敗: \(error)")
            }
        }
    }
}
