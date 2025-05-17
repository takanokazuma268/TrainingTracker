//
//  WorkoutSelectionView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI

struct WorkoutSelectionView: View {
    let passedDate: Date?
    @State private var selectedMainCategory: MainMuscleCategory? = nil
    @State private var selectedSubCategory: SubMuscleCategory? = nil
    @State private var selectedWorkoutID: WorkoutCategory? = nil
    @State private var isWorkoutLogView: Bool = false

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

    init(date: Date? = nil) {
        self.passedDate = date
    }

    var body: some View {
        if isWorkoutLogView {
            if let workoutID = selectedWorkoutID {
                WorkoutLogView(workoutCategory: workoutID, date: passedDate ?? Date())
            }
        } else {
            VStack(spacing: 8) {
                Spacer()

                Text("WORKOUT")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)

                HStack(spacing: 16) {
                    Menu {
                        ForEach(MuscleCategory.all, id: \.jaName) { mainCategory in
                            Button(mainCategory.jaName) {
                                selectedMainCategory = mainCategory
                                selectedSubCategory = nil
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedMainCategory?.jaName ?? "部位を選択")
                                .foregroundColor(.yellow)
                                .font(.headline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .fixedSize(horizontal: true, vertical: false)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.yellow)
                        }
                        .padding()
                    }

                    if let subCategories = selectedMainCategory?.subMuscleCategories {
                        Menu {
                            ForEach(subCategories, id: \.jaName) { subCategory in
                                Button(action: {
                                    selectedSubCategory = subCategory
                                }) {
                                    Text(subCategory.jaName)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedSubCategory?.jaName ?? "詳細を選択")
                                    .foregroundColor(.yellow)
                                    .font(.headline)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)
                                    .fixedSize(horizontal: true, vertical: false)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.yellow)
                            }
                            .padding()
                        }
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(WorkoutCategory.sampleData().filter { workout in
                            if let sub = selectedSubCategory {
                                return workout.subCategories.contains(where: { $0.code == sub.code })
                            } else if let main = selectedMainCategory {
                                return workout.mainCategories.contains(where: { $0.code == main.code })
                            } else {
                                return true
                            }
                        }) { workout in
                            WorkoutCard(workout: workout, isSelected: workout.code == selectedWorkoutID?.code)
                                .onTapGesture {
                                    selectedWorkoutID = workout
                                    print("Selected Workout Code: \(workout.code)")
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

#Preview {
    WorkoutSelectionView()
}
