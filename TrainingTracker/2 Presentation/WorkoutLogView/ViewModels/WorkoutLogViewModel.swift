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
    let workout: Workout
    
    @Published var date: Date
    @Published var sets: [WorkoutInputRow] = [
        WorkoutInputRow(set: 1),
        WorkoutInputRow(set: 2),
        WorkoutInputRow(set: 3)
    ]
    @Published var saveState: SaveState = .idle

    private var workoutRepo: WorkoutLogRepo?
    
    init(workout: Workout, date: Date) {
        self.workout = workout
        self.date = date
    }

    func setupRepository(with context: ModelContext) {
        self.workoutRepo = WorkoutLogRepo(context: context)
    }
    
    func handleSave() {
        guard isValidInput() else {
            saveState = .inputError
            return
        }
        
        if shouldShowOverwriteAlert() {
            saveState = .overwriteConfirmation
            return
        }
    
        saveWorkout()
    }

    func isValidInput() -> Bool {
        sets.contains { ($0.weight != nil) && ($0.reps != nil) }
    }

    private func shouldShowOverwriteAlert() -> Bool {
        guard let workoutRepo = workoutRepo else { return false }
        do {
            return try workoutRepo.exists(workout: workout, on: date)
        } catch {
            print("❌ Failed to check for existing log: \(error)")
            return false
        }
    }

    func saveWorkout() {
        guard let workoutRepo = workoutRepo else { return }

        do {
            let log = WorkoutLog(workoutCode: workout.code, date: date)
            log.sets = sets.compactMap { row -> WorkoutSet? in
                guard let weight = row.weight, let reps = row.reps else { return nil }
                return WorkoutSet(log: log, setNumber: row.set, weight: weight, reps: reps)
            }
            try workoutRepo.insert(log)
            saveState = .completed
        } catch {
            print("❌ Failed to save workout: \(error)")
        }
    }

    func updateWorkout() {
        guard let workoutRepo = workoutRepo else { return }

        do {
            let log = WorkoutLog(workoutCode: workout.code, date: date)
            log.sets = sets.compactMap { row in
                guard let weight = row.weight, let reps = row.reps else { return nil }
                return WorkoutSet(log: log, setNumber: row.set, weight: weight, reps: reps)
            }
            try workoutRepo.update(log)
            saveState = .completed
        } catch {
            print("❌ Failed to update workout: \(error)")
        }
    }
    
    func loadLatestWorkoutIfExists() {
        guard let workoutRepo = workoutRepo else { return }

        do {
            if let existing = try workoutRepo.fetchLatestLog(for: workout) {
                self.sets = existing.sets
                    .sorted(by: { $0.setNumber < $1.setNumber })
                    .map {
                        WorkoutInputRow(set: $0.setNumber, weight: $0.weight, reps: $0.reps)
                    }
            }
        } catch {
            print("❌ Failed to load latest workout log: \(error)")
        }
    }
}

enum SaveState {
    case idle
    case inputError
    case overwriteConfirmation
    case completed
}

extension WorkoutLogViewModel {
    func binding(for state: SaveState) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.saveState == state },
            set: { newValue in
                if !newValue && self.saveState == state {
                    self.saveState = .idle
                }
            }
        )
    }
}
