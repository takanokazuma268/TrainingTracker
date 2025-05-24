//
//  WorkoutInputRowView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct WorkoutInputRow: Identifiable {
    let id = UUID()
    var set: Int
    var weight: String = ""
    var reps: String = ""
}

struct WorkoutInputRowView: View {
    @Binding var row: WorkoutInputRow

    var body: some View {
        HStack {
            Text("\(row.set)")
                .frame(width: 35, alignment: .leading)
            Spacer()
            TextField("kg", text: $row.weight)
                .keyboardType(.decimalPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80, alignment: .leading)
            Spacer()
            TextField("reps", text: $row.reps)
                .keyboardType(.numberPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80, alignment: .leading)
        }
        .foregroundColor(.white)
    }
}

