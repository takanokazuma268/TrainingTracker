//
//  MainMuscle.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import SwiftData

struct MainMuscle: Codable, Identifiable ,Hashable{
    let code: String
    let jaName: String
    let enName: String
    let illustration: String
    let isFront: Bool

    var id: String { code }
}
