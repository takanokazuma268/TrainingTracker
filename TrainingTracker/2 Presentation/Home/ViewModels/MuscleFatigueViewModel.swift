//
//  MuscleFatiguePagerViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//
import SwiftData
import SwiftUI

class MuscleFatigueViewModel: ObservableObject {
    @Published var fatigueList: MuscleFatigueList?
    
    public func fetch(context: ModelContext) {
        do {
            let logs = try WorkoutLogRepo(context: context).fetchLatestDateByWorkout()
            
            fatigueList = MuscleFatigueList(
                mainMuscleCache: MainMuscleCache.shared,
                workoutCache: WorkoutCache.shared,
                logs: logs
            )
        } catch {
            print("Error fetching latest workout dates: \(error)")
        }
    }
}
