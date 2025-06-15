//
//  FatigueLevel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/25.
//
enum FatigueLevel {
    case high
    case low
    case none
    
    static func level(fromDays days: Int) -> FatigueLevel {
        switch days {
        case 0...1:
            return .high
        case 2:
            return .low
        default:
            return .none
        }
    }
}
