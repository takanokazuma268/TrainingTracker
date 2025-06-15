//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import SwiftUI

struct DayPickerView: View {
    @Binding var selectedDate: Date
    let availableDates: [Date]
    let onDateChange: (Date) -> Void
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        HStack {
            ForEach(availableDates, id: \.self) { date in
                let isSelected = selectedDate == date
                Text(date.weekdayAbbreviation)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(isSelected ? ThemeColor.from(mainColorName).color : AppColor.darkGray)
                    .foregroundColor(isSelected ? AppColor.black : AppColor.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedDate = date
                        onDateChange(date)
                    }
            }
        }
        .padding(.horizontal)
    }
}
