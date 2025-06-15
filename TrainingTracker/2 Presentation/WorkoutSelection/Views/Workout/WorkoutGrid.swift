//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct WorkoutGrid: View {
    @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel
    let onWorkoutTap: (Workout) -> Void

    var body: some View {
        GeometryReader { geometry in
            let spacing: CGFloat = AppSpacing.medium
            let cardWidth = (geometry.size.width - spacing * 2.5) / 2

            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing) {
                        ForEach(workoutSelectionVM.filteredWorkouts, id: \.code) { workout in
                            WorkoutCard(workout: workout, width: cardWidth) {
                                onWorkoutTap(workout)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width)
            }
        }
    }
}

private struct WorkoutCard: View {
    var workout: Workout
    var width: CGFloat
    var onTap: () -> Void = {}
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        let height = width // square card

        ZStack(alignment: .bottom) {
            if let imageName = workout.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: width, height: height)
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
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(ThemeColor.from(mainColorName).color, lineWidth: 1.5)
        )
        .onTapGesture {
            onTap()
        }
    }
}
