//
//  Protein.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import Foundation

enum Sex: String, CaseIterable {
    case 男性, 女性
}

enum ActivityLevel: String, CaseIterable {
    case 低, 中, 高
}

enum Goal: String, CaseIterable {
    case 健康維持, 筋肥大, 減量
}

struct ProteinIntakeCalculator {
    static func calculateGoal(weight: Double, sex: Sex) -> Double {
        switch sex {
        case .男性:
            return weight * 2.0
        case .女性:
            return weight * 1.6
        }
    }

    // 予備ロジック：活動レベルや目標も加味する場合の拡張
    static func calculateDetailedGoal(weight: Double, sex: Sex, age: Int?, activityLevel: ActivityLevel, goal: Goal) -> Double {
        var base: Double
        switch sex {
        case .男性: base = 2.0
        case .女性: base = 1.6
        }

        // 活動レベル補正
        let activityMultiplier: Double = {
            switch activityLevel {
            case .低: return 1.0
            case .中: return 1.1
            case .高: return 1.2
            }
        }()

        // 目標補正
        let goalMultiplier: Double = {
            switch goal {
            case .健康維持: return 1.0
            case .筋肥大: return 1.2
            case .減量: return 0.9
            }
        }()

        // 年齢補正（例: 高齢者はたんぱく質必要量がやや増える傾向）
        let ageMultiplier: Double = {
            guard let age = age else { return 1.0 }
            switch age {
            case ..<50: return 1.0
            case 50..<70: return 1.1
            default: return 1.2
            }
        }()

        return weight * base * activityMultiplier * goalMultiplier * ageMultiplier
    }
}
