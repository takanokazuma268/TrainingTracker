//
//  TestWorkSetLogView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI
import SwiftData


struct WorkoutLogListView: View {
    @Query(sort: \WorkoutLog.date, order: .reverse) var logs: [WorkoutLog]

    /// カテゴリ一覧（実際はViewModelやファイルから読み込む）
    let workoutCategories: [WorkoutCategory] = WorkoutCategory.sampleData()

    var body: some View {
        List {
            ForEach(logs) { log in
                VStack(alignment: .leading) {
                    Text("種目: \(jaName(for: log))")
                        .font(.headline)
                    Text("日付: \(formattedDate(log.date))")
                        .font(.subheadline)
                    Text("セット数: \(log.sets.count) セット")
                        .font(.subheadline)
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
    }

    private func jaName(for log: WorkoutLog) -> String {
        workoutCategories.first(where: { $0.code == log.workoutCode })?.jaName ?? "不明な種目"
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: date)
    }
}

#Preview {
    WorkoutLogListView()
        .modelContainer(for: WorkoutLog.self)
}
