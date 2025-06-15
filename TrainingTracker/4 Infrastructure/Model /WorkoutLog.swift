//
//  WorkoutLog.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import SwiftData
import Foundation

@Model
class WorkoutLog {
    @Attribute(.unique) var id: UUID
    var workoutCode: String
    var date: Date
    var sets: [WorkoutSet] = []

    init(id: UUID = UUID(), workoutCode: String, date: Date) {
        self.id = id
        self.workoutCode = workoutCode
        self.date = date
    }
}
