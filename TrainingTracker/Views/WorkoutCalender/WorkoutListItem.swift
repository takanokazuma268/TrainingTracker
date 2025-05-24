//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import SwiftUI

struct WorkoutListItem: View {
    let workout: WorkoutLog
    let workoutName: (String) -> String
    @ObservedObject var calendarVM: CalendarViewModel
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 48, height: 48)
                Image(systemName: "dumbbell.fill")
                    .foregroundColor(.black)
                    .font(.title2)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(workoutName(workout.workoutCode))
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        if let workoutCategory = WorkoutCategory.sampleData().first(where: { $0.code == workout.workoutCode }) {
                            // This action was in original code but no explicit use here, so omitted
                            // selectedWorkout = (workoutCategory, calendarVM.selectedDate)
                        }
                    }

                ForEach(workout.sets.sorted(by: { $0.setNumber < $1.setNumber })) { set in
                    Text(String(format: "Set %d: %.1fkg × %d回", set.setNumber, set.weight, set.reps))
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }

            Spacer()

            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}
