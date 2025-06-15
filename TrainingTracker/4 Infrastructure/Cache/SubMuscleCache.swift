//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import Foundation

class SubMuscleCache: BaseCache<SubMuscle> {
    static let shared = SubMuscleCache()
    private override init() {}

    func get(byCode code: String) -> SubMuscle? {
        return items.first { $0.code == code }
    }

    func get(byMainMuscleCode mainCode: String) -> [SubMuscle] {
        return items.filter { $0.mainMuscleCode == mainCode }
    }
}
