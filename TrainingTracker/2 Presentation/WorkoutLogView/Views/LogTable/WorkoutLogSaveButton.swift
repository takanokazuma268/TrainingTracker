//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//
import SwiftUI

struct WorkoutLogSaveButton: View {
    @ObservedObject var WorkoutLogVM: WorkoutLogViewModel
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        MainButtonView(
            action: {
                WorkoutLogVM.handleSave()
                if WorkoutLogVM.saveState == .completed {
                    navigationModel.path.removeLast(navigationModel.path.count)
                }
            },
            title: "トレーニングを記録",
            iconName: "pencil.and.list.clipboard"
        )
        .alert("既に同じ日のワークアウトが存在します。上書きしますか？", isPresented: WorkoutLogVM.binding(for: .overwriteConfirmation)) {
            Button("上書き", role: .destructive) {
                WorkoutLogVM.updateWorkout()
                if(WorkoutLogVM.saveState == .completed){
                    navigationModel.path.removeLast(navigationModel.path.count)
                }
            }
            Button("キャンセル", role: .cancel) {
                WorkoutLogVM.saveState = .idle
            }
        }
        .alert("重さと回数を入力してください", isPresented: WorkoutLogVM.binding(for: .inputError)) {
            Button("OK", role: .cancel) {
                WorkoutLogVM.saveState = .idle
            }
        }
    }
}
