//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct WorkoutGrid: View {
    var searchText: String
    var selectedMainCategory: MainMuscleCategory?
    var selectedSubCategory: SubMuscleCategory?
    @Binding var selectedWorkoutID: WorkoutCategory?
    var onWorkoutSelected: (WorkoutCategory) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(WorkoutCategory.sampleData().filter { workout in
                    let matchesSearch = searchText.isEmpty || workout.jaName.contains(searchText)
                    if let sub = selectedSubCategory {
                        return matchesSearch && workout.subCategories.contains { $0.code == sub.code }
                    } else if let main = selectedMainCategory {
                        return matchesSearch && workout.mainCategories.contains { $0.code == main.code }
                    } else {
                        return matchesSearch
                    }
                }) { workout in
                    WorkoutCard(workout: workout, isSelected: workout.code == selectedWorkoutID?.code)
                        .onTapGesture {
                            onWorkoutSelected(workout)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}


