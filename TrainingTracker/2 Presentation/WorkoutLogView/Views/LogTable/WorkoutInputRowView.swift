//
//  WorkoutInputRowView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct WorkoutInputRowView: View {
    @Binding var row: WorkoutInputRow

    var body: some View {
        HStack {
            Text("\(row.set)")
                .frame(width: UIScreen.screenWidth * 0.1, alignment: .leading)
            Spacer()
            WorkoutTextField(placeholder: "kg", value: $row.weight, keyboardType: .decimalPad)
            Spacer()
            WorkoutTextField(placeholder: "reps", value: $row.reps, keyboardType: .numberPad)
        }
        .foregroundColor(.white)
    }
}

struct WorkoutInputRow: Identifiable {
    let id = UUID()
    var set: Int
    var weight: Double?
    var reps: Int?
}

struct WorkoutTextField<T: LosslessStringConvertible>: View {
    let placeholder: String
    @Binding var value: T?
    let keyboardType: UIKeyboardType

    var body: some View {
        TextField(
            placeholder,
            text: Binding(
                get: { value.map(String.init) ?? "" },
                set: { newValue in
                    value = T(newValue)
                }
            )
        )
        .keyboardType(keyboardType)
        .padding(.horizontal, 8)
        .padding(.vertical, 9)
        .background(AppColor.darkGray)
        .cornerRadius(AppCornerRadius.medium)
        .frame(width: UIScreen.screenWidth * 0.2, alignment: .leading)
    }
}
