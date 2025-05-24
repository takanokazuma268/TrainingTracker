//
//  WorkoutLogView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutLogView: View {
    @StateObject private var viewModel: WorkoutLogViewModel
    @Environment(\.modelContext) private var modelContext
    @Binding var path: [Path]
    
    init(workoutCategory: WorkoutCategory, date: Date, path: Binding<[Path]>) {
        _viewModel = StateObject(wrappedValue: WorkoutLogViewModel(workoutCategory: workoutCategory, date: date, modelContext: nil,path: path))
        _path = path
    }

    var body: some View {
        VStack(spacing: 24) {
            WorkoutLogTitleView(workoutCategory: viewModel.workoutCategory)
            WorkoutLogDatePickerView(workoutDate: $viewModel.workoutDate)
            WorkoutLogSetListView(sets: $viewModel.sets)
            Spacer()
            WorkoutLogSaveButton(viewModel: viewModel)
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.loadLatestWorkoutIfExists()
        }
    }
}


#Preview {
    WorkoutLogView(workoutCategory: WorkoutCategory.sampleData().first!, date: Date(), path: .constant([]))
}
