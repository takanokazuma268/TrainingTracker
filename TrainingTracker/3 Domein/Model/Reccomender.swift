//
//  Reccomender.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/29.
//

import Foundation

struct Recommender {
    private let fatigueList: MuscleFatigueList

    init(fatigueList: MuscleFatigueList) {
        self.fatigueList = fatigueList
    }

    /// 本日おすすめの筋肉部位を返す（未トレーニング期間が長い順）
    func recommendMuscles(count: Int = 3) -> [MainMuscle] {
        let sorted = fatigueList.all()
            .sorted(by: { $0.lastWorkoutDate < $1.lastWorkoutDate })
        return sorted.prefix(count).map { $0.mainMuscle }
    }
}


