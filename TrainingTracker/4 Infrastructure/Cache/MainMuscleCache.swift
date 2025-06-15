//
//  MainMuscleCache.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import Foundation

class MainMuscleCache: BaseCache<MainMuscle> {
    static let shared = MainMuscleCache()
    private override init() {}

    func get(byCode code: String) -> MainMuscle? {
        return items.first { $0.code == code }
    }
}
