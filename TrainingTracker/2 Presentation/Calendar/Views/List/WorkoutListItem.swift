//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import SwiftUI

struct WorkoutListItem: View {
    let workoutlog: WorkoutLog
    var calenderVM: CalenderViewModel
    @State private var showAlert = false
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    var body: some View {
        HStack {
            IconCircleView(systemName: "dumbbell.fill", size: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(WorkoutCache.shared.getWorkout(byCode: workoutlog.workoutCode)?.jaName ?? "不明な種目")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(ThemeColor.from(mainColorName).color)

                ForEach(workoutlog.sets.sorted(by: { $0.setNumber < $1.setNumber })) { set in
                    Text(set.formattedDescription)
                        .foregroundColor(AppColor.white)
                        .font(.subheadline)
                }
            }

            Spacer()

            Button(action: {
                showAlert = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .alert("このトレーニングを削除しますか？", isPresented: $showAlert) {
            Button("削除", role: .destructive) {
                calenderVM.delete(workoutlog)
                calenderVM.loadWorkoutsForSelectedDate()
                calenderVM.loadWorkoutsForMonth()
            }
            Button("キャンセル", role: .cancel) { }
        }
    }
}
