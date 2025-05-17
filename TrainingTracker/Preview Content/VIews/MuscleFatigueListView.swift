//
//  MuscleCardView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/11.
//

import SwiftUI

struct MuscleFatigueListView: View {
    var muscleData: [(name: String, daysAgo: Int)] {
        let daysByName: [String: Int] = [
            "胸": 1,
            "背中": 3,
            "肩": 2,
            "前腕": 5,
            "上腕": 1,
            "腹筋": 6,
            "太もも": 2,
            "お尻": 4,
            "ふくらげ": 0
        ]
        return MuscleCategory.all.map { ($0.jaName, daysByName[$0.jaName] ?? 0) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(muscleData, id: \.name) { data in
                    MuscleCard(muscle: data.name, daysAgo: data.daysAgo)
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
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
    MuscleFatigueListView()
}
