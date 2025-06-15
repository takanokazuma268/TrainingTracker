//
//  TrainingTrackerTests.swift
//  TrainingTrackerTests
//
//  Created by 高野和馬 on 2025/05/06.
//

import XCTest
import SwiftData
@testable import TrainingTracker

final class TrainingTrackerTests: XCTestCase {
    func testMainMuscleCacheLoading() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "main_muscle", withExtension: "json") else {
            XCTFail("Failed to locate main_muscle.json in test bundle.")
            return
        }
        
        do {
            try MainMuscleCache.shared.load(from: url)
        } catch {
            XCTFail("Failed to load main_muscle.json: \(error)")
            return
        }
        
        for muscle in MainMuscleCache.shared.items {
            print("Code: \(muscle.code), Name: \(muscle.jaName), Illustration: \(muscle.illustration)")
        }
    }
    
    
    func testInsertAndFetchAllWorkoutLogs() throws {
        // Create an in-memory model container for testing
        let schema = Schema([WorkoutLog.self, WorkoutSet.self])
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [modelConfig])
        let context = ModelContext(container)
        let repo = WorkoutLogRepo(context: context)

        // Insert one WorkoutLog
        let log = WorkoutLog(workoutCode: "WK001", date: Date())
        try repo.insert(log)

        // Insert three related WorkoutSet entries
        let set1 = WorkoutSet(log: log, setNumber: 1, weight: 40.0, reps: 10)
        let set2 = WorkoutSet(log: log, setNumber: 2, weight: 45.0, reps: 8)
        let set3 = WorkoutSet(log: log, setNumber: 3, weight: 50.0, reps: 6)
        context.insert(set1)
        context.insert(set2)
        context.insert(set3)

        // Fetch all WorkoutLogs
        let fetchedLogs = try repo.fetchAll()

        // Print results
        for fetchedLog in fetchedLogs {
            print("WorkoutLog - ID: \(fetchedLog.id), Code: \(fetchedLog.workoutCode), Date: \(fetchedLog.date)")
            for set in fetchedLog.sets {
                print("  WorkoutSet - Set #: \(set.setNumber), Weight: \(set.weight), Reps: \(set.reps)")
            }
        }

        // Assert
        XCTAssertEqual(fetchedLogs.count, 1, "Expected 1 workout log")
        XCTAssertEqual(fetchedLogs.first?.sets.count, 3, "Expected 3 workout sets")
    }
}
