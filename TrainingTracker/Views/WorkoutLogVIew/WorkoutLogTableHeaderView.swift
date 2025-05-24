//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogTableHeaderView: View {
    var body: some View {
        HStack {
            Text("SET")
                .frame(width: WorkoutLogConstants.setWidth, alignment: .leading)
            Spacer()
            Text("WEIGHT")
                .frame(width: WorkoutLogConstants.weightWidth, alignment: .leading)
            Spacer()
            Text("REPS")
                .frame(width: WorkoutLogConstants.repsWidth, alignment: .leading)
        }
        .foregroundColor(.yellow)
        .font(.headline)
        Divider().background(Color.yellow)
    }
}

struct WorkoutLogConstants {
    static let setWidth: CGFloat = 40
    static let weightWidth: CGFloat = 80
    static let repsWidth: CGFloat = 80
}
