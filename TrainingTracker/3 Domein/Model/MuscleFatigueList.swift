//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/29.
//
import Foundation

struct MuscleFatigueList {
    private var items: [MuscleFatigue] = []
    
    init(items: [MuscleFatigue]) {
        self.items = items
    }
    
    init(mainMuscleCache: MainMuscleCache,workoutCache: WorkoutCache,logs: [String: Date]) {
        self.items = Self.generateItems(mainMuscleCache: mainMuscleCache, workoutCache: workoutCache, logs: logs)
    }
    
    private static func generateItems(mainMuscleCache: MainMuscleCache, workoutCache: WorkoutCache, logs: [String: Date]) -> [MuscleFatigue] {
        var result: [MuscleFatigue] = []
        
        for mainMuscle in mainMuscleCache.items {
            guard let latestDate = latestWorkoutDate(for: mainMuscle, workoutCache: workoutCache, logs: logs
            ) else {
                continue
            }
            
            let daysSinceWorkout = Calendar.current.dateComponents([.day], from: latestDate, to: Date()).day ?? Int.max
            let level = FatigueLevel.level(fromDays: daysSinceWorkout)
            
            result.append(MuscleFatigue(mainMuscle: mainMuscle, lastWorkoutDate: latestDate, level: level))
        }
        
        return result
    }
    
    private static func latestWorkoutDate(for mainMuscle: MainMuscle,workoutCache: WorkoutCache,logs: [String: Date]) -> Date? {
        let relatedWorkouts = workoutCache.getByMainMuscleCode(mainMuscle.code)
        let relatedWorkoutCodes = Set(relatedWorkouts.map { $0.code })
        
        return logs
            .filter { relatedWorkoutCodes.contains($0.key) }
            .map { $0.value }
            .max()
    }
    
    func all() -> [MuscleFatigue] {
        items
    }
    
    func date(for muscleCode: String) -> Date? {
        items.first { $0.mainMuscle.code == muscleCode }?.lastWorkoutDate
    }
    
    func muscles(on date: Date) -> [MainMuscle] {
        items.filter { Calendar.current.isDate($0.lastWorkoutDate, inSameDayAs: date) }
            .map { $0.mainMuscle }
    }
    
    func front() -> [MuscleFatigue] {
        items.filter { $0.mainMuscle.isFront }
    }
    
    func back() -> [MuscleFatigue] {
        items.filter { !$0.mainMuscle.isFront }
    }
}

