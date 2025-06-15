//
//  dd.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/25.
//
import SwiftUI

struct MuscleFatigueCardView: View {
    let categoryName: String
    let daysAgo: Int

    var body: some View {
        HStack {
            Text("\(categoryName)トレ")
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text("\(daysAgo)日前")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(gradientColor(for: daysAgo))
        .cornerRadius(AppCornerRadius.large)
    }

    private func gradientColor(for days: Int) -> LinearGradient {
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
