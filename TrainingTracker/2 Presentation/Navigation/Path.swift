//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

enum AppPath: Hashable {
    case home
    case workoutCalender
    case workoutSelection(recordDate: Date)
    case workoutLog(workout: Workout, date: Date)
    case protein
    case proteinChar
    case analysis(workout: Workout)

    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .home:
            HomeView()
        case .workoutCalender:
            WorkoutCalendarView()
        case .workoutSelection(let date):
            WorkoutSelectionView(passedDate: date)
        case .workoutLog(let workout, let date):
            WorkoutLogView(workout: workout, date: date)
        case .protein:
            ProteinView()
        case .proteinChar:
            ProteinChartView()
        case .analysis(let workout):
            AnalysisView(workout: workout)
        }
    }
}
