//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct CategoryPickerSheet: View {
    @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel
    //@Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppColor.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    MainMuscleSelectionView(workoutSelectionVM: workoutSelectionVM)
                    SubMuscleSelectionView(workoutSelectionVM: workoutSelectionVM)
                }
                .padding(.top)
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .presentationDetents([.fraction(0.4), .medium])
    }
}

struct MainMuscleSelectionView: View {
    @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppSpacing.medium) {
                let allMainMuscles: [MainMuscle?] = [nil] + MainMuscleCache.shared.items

                ForEach(allMainMuscles, id: \.?.jaName) { mainMuscle in
                    Button(action: {
                        workoutSelectionVM.selectMainMuscle(mainMuscle)
                    }) {
                        Text(mainMuscle?.jaName ?? "選択なし")
                            .padding(.vertical, AppSpacing.medium)
                            .padding(.horizontal, AppSpacing.large)
                            .background(
                                workoutSelectionVM.selectedMainMuscle == mainMuscle
                                ? Color.yellow : AppColor.darkGray
                            )
                            .foregroundColor(.white)
                            .cornerRadius(AppCornerRadius.medium)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SubMuscleSelectionView: View {
    @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        let subMuscles = workoutSelectionVM.getFilteredSubMuscles()
        if subMuscles.count > 0 {
            VStack(alignment: .leading, spacing: 12) {
                DescriptionText(text:"詳細カテゴリ")

                ForEach(subMuscles, id: \.jaName) { subMuscle in
                    Button(action: {
                        workoutSelectionVM.selectedSubMuscle = subMuscle
                    }) {
                        HStack {
                            Text(subMuscle.jaName)
                                .foregroundColor(AppColor.white)
                            Spacer()
                            if workoutSelectionVM.selectedSubMuscle?.code == subMuscle.code {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(ThemeColor.from(mainColorName).color)
                            }
                        }
                        .cardStyle()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                }
            }
        }
    }
}
