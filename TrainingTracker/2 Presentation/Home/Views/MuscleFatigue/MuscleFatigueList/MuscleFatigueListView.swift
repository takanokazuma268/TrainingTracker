//
//  MuscleCardView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/11.
//
import SwiftUI

struct MuscleFatigueListView: View {
    let fatigueList : MuscleFatigueList

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.medium) {
                ForEach(fatigueList.all(), id: \.mainMuscle.code) { fatigueInfo in
                    MuscleFatigueCardView(
                        categoryName: fatigueInfo.mainMuscle.jaName,
                        daysAgo: fatigueInfo.lastWorkoutDate.daysAgo()
                    )
                }
            }
            .padding()
        }
    }
}
