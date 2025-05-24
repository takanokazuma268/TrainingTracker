//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogSetListView: View {
    @Binding var sets: [WorkoutInputRow]
    var body: some View {
        VStack(spacing: 12) {
            WorkoutLogTableHeaderView()
            ForEach($sets) { $row in
                HStack {
                    WorkoutInputRowView(row: $row)
                    Button(action: {
                        sets.removeAll { $0.id == row.id }
                        for index in sets.indices {
                            sets[index].set = index + 1
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            Button(action: {
                let nextSet = sets.count + 1
                sets.append(WorkoutInputRow(set: nextSet))
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
