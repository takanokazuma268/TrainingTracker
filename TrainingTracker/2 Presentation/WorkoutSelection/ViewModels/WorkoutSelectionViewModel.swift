//
//  W.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/29.
//

import Foundation
import SwiftUI

class WorkoutSelectionViewModel: ObservableObject {
    @Published var allWorkouts: [Workout] = []
    @Published var searchText: String = ""
    @Published var selectedMainMuscle: MainMuscle? = nil
    @Published var selectedSubMuscle: SubMuscle? = nil
    
    var filteredWorkouts: [Workout] {
        allWorkouts.filter { workout in
            let matchesSearch = ( searchText.isEmpty || workout.jaName.localizedCaseInsensitiveContains(searchText))
            let matchesMain = (selectedMainMuscle == nil || workout.mainMuscles.contains(selectedMainMuscle!))
            let matchesSub = (selectedSubMuscle == nil || workout.subMuscles.contains(selectedSubMuscle!))
            return matchesSearch && matchesMain && matchesSub
        }
    }

    func loadWorkouts() {
        self.allWorkouts = WorkoutCache.shared.items
    }
    
    func selectMainMuscle(_ mainMuscle: MainMuscle?) {
        selectedMainMuscle = mainMuscle
        selectedSubMuscle = nil
    }
    
    func getFilteredSubMuscles() -> [SubMuscle] {
        guard let code = selectedMainMuscle?.code else { return [] }
        return SubMuscleCache.shared.get(byMainMuscleCode: code)
    }
}
