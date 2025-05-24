//
//  FilterButtonView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct FilterButtonWithSheet: View {
    @Binding var isPresented: Bool
    @Binding var selectedMainCategory: MainMuscleCategory?
    @Binding var selectedSubCategory: SubMuscleCategory?

    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.title2)
                .foregroundColor(.yellow)
        }
        .sheet(isPresented: $isPresented) {
            CategoryPickerSheet(
                selectedMainCategory: $selectedMainCategory,
                selectedSubCategory: $selectedSubCategory,
                isPresented: $isPresented
            )
        }
    }
}
