//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogSaveButton: View {
    @ObservedObject var viewModel: WorkoutLogViewModel
    var body: some View {
        Button(action: {
            viewModel.handleSave()
        }) {
            Text("SAVE")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .padding(.bottom, 24)
        .alert("既に同じ日のワークアウトが存在します。上書きしますか？", isPresented: $viewModel.showOverwriteAlert) {
            Button("上書き", role: .destructive) {
                if let existing = viewModel.existingLogToReplace {
                    viewModel.saveWorkout(replacing: existing)
                }
            }
            Button("キャンセル", role: .cancel) {}
        }
        .alert("重さと回数を入力してください", isPresented: $viewModel.showInputErrorAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}
