//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogTitleView: View {
    let workout: Workout
    var body: some View {
        Text(workout.jaName)
            .font(.title)
            .foregroundColor(.yellow)
            .bold()
    }
}
