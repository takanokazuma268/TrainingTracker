//
//  MuscleCardView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/11.
//

import SwiftUI

struct MuscleFatigueListView: View {
    let fatigueDataList: [FatigueInfo]

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(fatigueDataList) { data in
                    MuscleCard(muscle: data.muscleCategory.jaName, daysAgo: data.difftoday)
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            .padding(.bottom)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct MuscleCard: View {
    var muscle: String
    var daysAgo: Int

    var body: some View {
        HStack {
            Text("\(muscle)トレ")
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text("\(daysAgo)日前")
                .foregroundColor(.white)
                .font(.subheadline)
        }
        .padding()
        .background(gradientColor(for: daysAgo))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)

    }

    func gradientColor(for days: Int) -> LinearGradient {
        switch days {
        case 0...1:
            return LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                startPoint: .topLeading, endPoint: .bottomTrailing)
        case 2:
            return LinearGradient(
                gradient: Gradient(colors: [Color.yellow, Color.orange]),
                startPoint: .topLeading, endPoint: .bottomTrailing)
        default:
            return LinearGradient(
                gradient: Gradient(colors: [Color(.darkGray), Color.black]),
                startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
#Preview {
    MuscleFatigueListView(fatigueDataList: [
        FatigueInfo(muscleCategory: MuscleCategory.chest, difftoday: 1, level: .high),
        FatigueInfo(muscleCategory: MuscleCategory.back, difftoday: 3, level: .low),
        FatigueInfo(muscleCategory: MuscleCategory.sholder, difftoday: 2, level: .low)
    ])
}
