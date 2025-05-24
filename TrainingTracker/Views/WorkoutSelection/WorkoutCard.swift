//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct WorkoutCard: View {
    var workout: WorkoutCategory
    var isSelected: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            if let imageName = workout.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipped()
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 160, height: 160)
                    Text("No Image")
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }

            Text(workout.jaName.uppercased())
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .padding(6)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.6))
        }
        .frame(width: 180, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.yellow : Color.yellow, lineWidth: 1.5)
        )
    }
}
