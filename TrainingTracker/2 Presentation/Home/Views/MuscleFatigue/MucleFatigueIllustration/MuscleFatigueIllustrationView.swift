//
//  MuscleFatigueImageView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/25.
//
import SwiftUI

struct MuscleFatigueIllustrationView: View {
    
    let fatigueList: MuscleFatigueList
    
    var body: some View {
        VStack() {
            HStack {
                MuscleFatigueImage(muscleFatigueList: MuscleFatigueList(items: fatigueList.front()), baseImageName: "front_base")
                MuscleFatigueImage(muscleFatigueList: MuscleFatigueList(items: fatigueList.back()), baseImageName: "back_base")
            }
            
            HStack(spacing: AppSpacing.medium) {
                FatigueLegendItem(fatigueLevel: .high, label: "：0〜1日前")
                FatigueLegendItem(fatigueLevel: .low, label: "：2日前")
            }
        }
    }
}


private struct FatigueLegendItem: View {
    let fatigueLevel: FatigueLevel
    let label: String

    var body: some View {
        HStack(spacing: AppSpacing.medium) {
            Circle()
                .fill(fatigueLevel.color)
                .frame(width: 12, height: 12)
            Text(label)
                .font(.caption)
                .foregroundColor(AppColor.lightGray)
        }
    }
}
