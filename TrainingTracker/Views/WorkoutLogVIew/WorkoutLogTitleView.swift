//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogTitleView: View {
    let workoutCategory: WorkoutCategory
    var body: some View {
        Text(workoutCategory.jaName)
            .font(.title)
            .foregroundColor(.yellow)
            .bold()
    }
}
