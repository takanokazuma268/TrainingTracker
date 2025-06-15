//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//
import SwiftUI

struct WorkoutLogSetListView: View {
    @ObservedObject var WorkoutLogVM: WorkoutLogViewModel
    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            WorkoutLogTableHeaderView()
            
            ScrollView {
                ForEach($WorkoutLogVM.sets) { $row in
                    HStack {
                        WorkoutInputRowView(row: $row)
                        Button(action: {
                            WorkoutLogVM.sets.removeAll { $0.id == row.id }
                            for index in WorkoutLogVM.sets.indices {
                                WorkoutLogVM.sets[index].set = index + 1
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .frame(height: 170)
            
            Button(action: {
                let currentSet = WorkoutLogVM.sets.count
                let nextSet = currentSet + 1
                WorkoutLogVM.sets.append(WorkoutInputRow(set: nextSet, weight:  WorkoutLogVM.sets.last?.weight ?? 0, reps: WorkoutLogVM.sets.last?.reps ?? 0))
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Set")
                }
                .foregroundColor(.yellow)
            }
        }
        .padding()
    }
}
