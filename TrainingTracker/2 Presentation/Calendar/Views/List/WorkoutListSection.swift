//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//
import SwiftUI
import SwiftData

struct WorkoutListSection: View {
    @ObservedObject var calenderVM: CalenderViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            if calenderVM.isWorkoutEmpty() {
                Text("No workouts recorded.")
                    .foregroundColor(AppColor.lightGray)
            } else {
                ScrollView {
                    let workouts = Array(calenderVM.workoutLogs.enumerated())
                    ForEach(workouts, id: \.element.id) { index, workoutlog in
                        WorkoutListItem(workoutlog: workoutlog, calenderVM: calenderVM)
                            .cardStyle()
                    }
                }
                .frame(maxHeight: UIScreen.screenHeight / 3)
            }
        }.padding(.horizontal)
    }
}
