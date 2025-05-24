//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//
import SwiftUI
import SwiftData

struct WorkoutListSection: View {
    @ObservedObject var calendarVM: CalendarViewModel
    let workouts: [WorkoutLog]
    let workoutName: (String) -> String
    @Binding var path: [Path]
    var modelContext: ModelContext

    @State private var workoutToDelete: WorkoutLog?

    let calendar = Calendar.current

    var todayWorkouts: [WorkoutLog] {
        workouts.filter {
            calendar.isDate($0.date, inSameDayAs: calendarVM.selectedDate)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if todayWorkouts.isEmpty {
                Text("No workouts recorded.")
                    .foregroundColor(.gray)
            } else {
                ScrollView {
                    ForEach(Array(todayWorkouts.enumerated()), id: \.element.id) { index, workout in
                        WorkoutListItem(
                            workout: workout,
                            workoutName: workoutName,
                            calendarVM: calendarVM,
                            onDelete: {
                                workoutToDelete = workout
                            }
                        )
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .offset(y: CGFloat(index) * -12)
                    }
                }
                .frame(height: 320)
                .alert("このトレーニングを削除しますか？", isPresented: Binding<Bool>(
                    get: { workoutToDelete != nil },
                    set: { if !$0 { workoutToDelete = nil } }
                )) {
                    Button("削除", role: .destructive) {
                        if let workout = workoutToDelete {
                            modelContext.delete(workout)
                            do {
                                try modelContext.save()
                            } catch {
                                print("❌ Failed to delete workout: \(error)")
                            }
                            workoutToDelete = nil
                        }
                    }
                    Button("キャンセル", role: .cancel) {
                        workoutToDelete = nil
                    }
                }
            }

            Button(action: {
                path.append(Path.workoutSelection(date: calendarVM.selectedDate))
            }) {
                Text("＋ トレーニングを追加")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding(.top, 8)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
