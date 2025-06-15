//
//  WorkoutLogView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutLogView: View {
    let passedDate: Date
    let workout: Workout
    @EnvironmentObject var navigationModel: NavigationModel
    @Environment(\.modelContext) private var modelContext
    @StateObject private var WorkoutLogVM: WorkoutLogViewModel

    init(workout: Workout, date: Date) {
        self.passedDate = date
        self.workout = workout
        _WorkoutLogVM = StateObject(wrappedValue: WorkoutLogViewModel(workout: workout, date: date))
    }
    
    var body: some View {
        BaseNavigationView {
            VStack(spacing: AppSpacing.medium) {
                WorkoutHeroView(workout: workout)
                DatePickerView(date: $WorkoutLogVM.date)
                WorkoutLogSetListView(WorkoutLogVM: WorkoutLogVM)
                Spacer()
                WorkoutLogSaveButton(WorkoutLogVM: WorkoutLogVM)
                Spacer()
            }
            .onAppear {
                WorkoutLogVM.setupRepository(with: modelContext)
                WorkoutLogVM.loadLatestWorkoutIfExists()
            }
            .baseScreenStyle()
        }
    }
}

#Preview {
    let sampleWorkout = Workout(
        code: "WK_01",
        jaName: "ベンチプレス",
        enName: "Bench Press",
        imageName: "UA_Dips",
        mainMuscles: [],
        subMuscles: [],
        equipment: ["ベンチ", "バーベル"],
        displayPriority: 1
    )
    
    WorkoutLogView(workout: sampleWorkout, date: Date())
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
        .environmentObject(NavigationModel())
    
}

