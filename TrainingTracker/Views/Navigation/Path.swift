//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

enum Path: Hashable {
    case home
    case workoutCalender
    case workoutSelection(date: Date)
    case test
    case workoutLog(workout: WorkoutCategory, date: Date)

    @ViewBuilder
    func destinationView(path: Binding<[Path]>) -> some View {
        switch self {
        case .home:
            HomeView(path: path)
        case .workoutCalender:
            WorkoutCalendarView(path: path)
        case .workoutSelection(let date):
            WorkoutSelectionView(passedDate: date, path: path)
        case .workoutLog(let workout, let date):
            WorkoutLogView(workoutCategory: workout, date: date, path: path)
        case .test:
            HomeView(path: path)
        }
    }
}
