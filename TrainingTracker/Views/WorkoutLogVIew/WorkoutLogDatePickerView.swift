//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogDatePickerView: View {
    @Binding var workoutDate: Date
    var body: some View {
        HStack {
            Text("Date")
                .foregroundColor(.white)
            DatePicker("", selection: $workoutDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

