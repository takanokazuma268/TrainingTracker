//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct CategoryPickerSheet: View {
    @Binding var selectedMainCategory: MainMuscleCategory?
    @Binding var selectedSubCategory: SubMuscleCategory?
    @Binding var isPresented: Bool

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            // Main category horizontal scroll
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Button(action: {
                        selectedMainCategory = nil
                        selectedSubCategory = nil
                    }) {
                        Text("選択なし")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedMainCategory == nil ? Color.yellow : Color.gray.opacity(0.3))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    ForEach(MuscleCategory.all, id: \.jaName) { mainCategory in
                        Button(action: {
                            selectedMainCategory = mainCategory
                            selectedSubCategory = nil
                        }) {
                            Text(mainCategory.jaName)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(selectedMainCategory?.jaName == mainCategory.jaName ? Color.yellow : Color.gray.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }

            // Subcategories always visible
            if let subCategories = selectedMainCategory?.subMuscleCategories {
                VStack(alignment: .leading, spacing: 12) {
                    Text("詳細カテゴリ")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(subCategories, id: \.jaName) { subCategory in
                        Button(action: {
                            selectedSubCategory = subCategory
                        }) {
                            HStack {
                                Text(subCategory.jaName)
                                    .foregroundColor(.white)
                                Spacer()
                                if selectedSubCategory?.code == subCategory.code {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal)
                    }
                }
            }

            Spacer()

            // OK button
            Button(action: {
                dismiss()
            }) {
                Text("OK")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
        }
        .padding(.top)
        .background(Color.black.ignoresSafeArea())
        .presentationDetents([.medium, .large])

    }
}
