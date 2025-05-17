//
//  WorkoutSet.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/11.
//

import Foundation
import SwiftData

@Model
class WorkoutSet {
    var setNumber: Int
    var weight: Double
    var reps: Int

    init(setNumber: Int, weight: Double, reps: Int) {
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
    }
}
