//
//  SubMuscle.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//

struct SubMuscle: Codable, Identifiable ,Hashable{
    let code: String
    let jaName: String
    let enName: String
    let mainMuscleCode: String

    var id: String { code }
}
