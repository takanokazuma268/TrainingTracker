//
//  FilterButtonView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI
struct WorkoutSelectionHeaderView: View {
    @Binding var isCategoryPickerPresented: Bool
    @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel


    var body: some View {
        HStack {
            SearchFieldView(text: $workoutSelectionVM.searchText)

            Spacer()

            FilterButtonWithSheet(
                isPresented: $isCategoryPickerPresented,
                workoutSelectionVM: workoutSelectionVM
            )
        }
    }
    
    private struct FilterButtonWithSheet: View {
        @Binding var isPresented: Bool
        @ObservedObject var workoutSelectionVM: WorkoutSelectionViewModel
        @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
        
        var body: some View {
            Button(action: {
                isPresented = true
            }) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.title2)
                    .foregroundColor(ThemeColor.from(mainColorName).color)
            }
            .sheet(isPresented: $isPresented) {
                CategoryPickerSheet(
                    workoutSelectionVM: workoutSelectionVM
                )
            }
        }
    }
}



