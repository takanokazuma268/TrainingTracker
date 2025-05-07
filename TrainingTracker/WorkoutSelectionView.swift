//
//  WorkoutSelectionView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI

struct WorkoutSelectionView: View {
    @State private var selectedBodyPart = "All"
    @State private var selectedWorkoutID: UUID? = nil
    @State private var isWorkoutLogView: Bool = false

    let bodyParts = ["All", "Chest", "Legs", "Back"]
    
    struct Workout: Identifiable {
        let id = UUID()
        let imageName: String
        let title: String
    }

    let workouts = [
        Workout(imageName: "C_BenchPress", title: "BENCH\nPRESS"),
        Workout(imageName: "F_DeadLift", title: "DEADLIFT"),
        Workout(imageName: "S_SholderPress", title: "SHOULDER\nPRESS"),
        Workout(imageName: "A_Crunch", title: "CRUNCH"),
        Workout(imageName: "AR_WristCurl", title: "WRIST\nCURL"),
        Workout(imageName: "C_ChestPress", title: "CHEST\nPRESS"),
        Workout(imageName: "C_BenchPress", title: "BENCH\nPRESS"),
        Workout(imageName: "F_DeadLift", title: "DEADLIFT"),
        Workout(imageName: "S_SholderPress", title: "SHOULDER\nPRESS"),
        Workout(imageName: "A_Crunch", title: "CRUNCH"),
        Workout(imageName: "AR_WristCurl", title: "WRIST\nCURL"),
        Workout(imageName: "C_ChestPress", title: "CHEST\nPRESS")
    ]

    struct WorkoutCard: View {
        var workout: Workout
        var isSelected: Bool

        var body: some View {
            VStack {
                Image(workout.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(12)

                Text(workout.title)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
            }
            .frame(width: 150, height: 150)
            .padding()
            .background(isSelected ? Color.yellow.opacity(0.3) : Color.black.opacity(0.8))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.yellow : Color.yellow, lineWidth: 2)
            )
        }
    }


    var body: some View {
        if isWorkoutLogView {
            WorkoutLogView()
        } else {
            VStack(spacing: 8) {
                Spacer()
                
                Text("WORKOUT")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                
                Menu {
                    ForEach(bodyParts, id: \.self) { part in
                        Button(action: {
                            selectedBodyPart = part
                        }) {
                            Text(part)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedBodyPart)
                            .foregroundColor(.yellow)
                            .font(.headline)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.yellow)
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(workouts) { workout in
                            WorkoutCard(workout: workout, isSelected: workout.id == selectedWorkoutID)
                                .onTapGesture {
                                    selectedWorkoutID = workout.id
                                    isWorkoutLogView = true
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

struct WorkoutCard: View {
    var imageName: String
    var title: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(12)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
    }
}

#Preview {
    WorkoutSelectionView()
}
