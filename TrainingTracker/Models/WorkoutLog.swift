//
//  WorkoutLog.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/11.
//

import Foundation
import SwiftData

@Model
class WorkoutLog: Identifiable {
    @Attribute(.unique) var id: UUID
    var workoutCode: String
    var date: Date
    @Relationship(deleteRule: .cascade)
    var sets: [WorkoutSet]

    init(id: UUID = UUID(), workoutCode: String, date: Date, sets: [WorkoutSet]) {
        self.id = id
        self.workoutCode = workoutCode
        self.date = date
        self.sets = sets
    }
    
    var category: WorkoutCategory? {
        return WorkoutCategory.sampleData().first(where: { $0.code == self.workoutCode })
    }
}
