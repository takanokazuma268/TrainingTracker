//
//  WorkoutSelectionView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI

struct WorkoutSelectionView: View {
    let passedDate: Date
    @Binding var path: [Path]
    
    @State private var selectedMainCategory: MainMuscleCategory? = nil
    @State private var selectedSubCategory: SubMuscleCategory? = nil
    @State private var selectedWorkoutID: WorkoutCategory? = nil
    @State private var searchText: String = ""
    @State private var isCategoryPickerPresented: Bool = false

    var body: some View {
        NavigationStack(path: $path){
            VStack(spacing: 8) {
                Text("WORKOUT")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    SearchFieldView(searchText: $searchText)

                    FilterButtonWithSheet(
                        isPresented: $isCategoryPickerPresented,
                        selectedMainCategory: $selectedMainCategory,
                        selectedSubCategory: $selectedSubCategory
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                WorkoutGrid(searchText: searchText,
                            selectedMainCategory: selectedMainCategory,
                            selectedSubCategory: selectedSubCategory,
                            selectedWorkoutID: $selectedWorkoutID) { workout in
                    selectedWorkoutID = workout
                    print("Selected Workout Code: \(workout.code)")
                    path.append(Path.workoutLog(workout: workout, date: passedDate))
                }
                
                Spacer()
                
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationDestination(for: Path.self) { path in
                path.destinationView(path: $path)
            }
        }
    }
}

#Preview {
    WorkoutSelectionView(passedDate: Date(), path: .constant([]))
}
