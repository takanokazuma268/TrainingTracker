//
//  WorkoutSelectionView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI

struct WorkoutSelectionView: View {
    let passedDate: Date
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var workoutSelectionVM = WorkoutSelectionViewModel()
    @State private var isCategoryPickerPresented: Bool = false
    @AppStorage("selectedTab") private var selectedTabRaw: String = "calendar"
    
    private var selectedTab: ContentView.Tab {
        ContentView.Tab(rawValue: selectedTabRaw) ?? .calendar
    }

    var body: some View {
        BaseNavigationView {
            VStack {
                WorkoutSelectionHeaderView(
                    isCategoryPickerPresented: $isCategoryPickerPresented,
                    workoutSelectionVM: workoutSelectionVM
                )
                
                Spacer()
                
                WorkoutGrid(workoutSelectionVM: workoutSelectionVM) { selectedWorkout in
                    if selectedTab == .analysis {
                        navigationModel.path.append(AppPath.analysis(workout: selectedWorkout))
                    } else {
                        navigationModel.path.append(AppPath.workoutLog(workout: selectedWorkout, date: passedDate))
                    }
                }
                
                Spacer()
            }
            .onAppear {
                workoutSelectionVM.loadWorkouts()
            }
        }
    }
}

#Preview {
    return WorkoutSelectionView(passedDate: Date())
        .environmentObject(NavigationModel())
}
