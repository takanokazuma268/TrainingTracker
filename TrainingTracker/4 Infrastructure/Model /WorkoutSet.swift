//  WorkoutSet.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
//
import SwiftData
import Foundation

@Model
class WorkoutSet {
    @Attribute(.unique) var id: UUID
    @Relationship(inverse: \WorkoutLog.sets)
    var log: WorkoutLog?
    var setNumber: Int
    var weight: Double
    var reps: Int

    var formattedDescription: String {
        String(format: "Set %d: %.1fkg × %d回", setNumber, weight, reps)
    }

    init(id: UUID = UUID(), log: WorkoutLog?, setNumber: Int, weight: Double, reps: Int) {
        self.id = id
        self.log = log
        self.setNumber = setNumber
        self.weight = weight
        self.reps = reps
    }
}
