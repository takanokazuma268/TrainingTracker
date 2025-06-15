//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(ThemeColor.from(mainColorName).color)
                .font(.title3)
            DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
                .background(AppColor.darkGray)
                .cornerRadius(AppCornerRadius.medium)
        }
        .padding()
    }
}
