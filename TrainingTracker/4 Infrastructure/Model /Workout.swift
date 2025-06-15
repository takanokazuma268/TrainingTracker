//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//

struct Workout: Codable, Identifiable ,Hashable{
    let code: String
    let jaName: String
    let enName: String
    let imageName: String?
    let mainMuscles: [MainMuscle]
    let subMuscles: [SubMuscle]
    let equipment: [String]?
    let displayPriority: Int

    var id: String { code }
}
