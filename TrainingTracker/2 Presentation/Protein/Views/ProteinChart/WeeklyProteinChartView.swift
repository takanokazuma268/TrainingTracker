//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import SwiftUI
import Charts

struct WeeklyProteinChartView: View {
    let weeklyData: [(Date, Double)]
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        Chart {
            ForEach(weeklyData, id: \.0) { day, amount in
                BarMark(
                    x: .value("Day", day.weekdayAbbreviation),
                    y: .value("Amount", amount)
                )
                .foregroundStyle(ThemeColor.from(mainColorName).color)
                .accessibilityLabel(day.weekdayAbbreviation)
                .accessibilityValue("\(amount)g")
                .annotation(position: .top, alignment: .center) {
                    Text("\(Int(amount))g")
                        .font(.caption)
                        .foregroundColor(AppColor.white)
                }
            }
        }
        .workoutChartStyle()
        .chartXVisibleDomain(length: 7)
        .frame(height: UIScreen.screenHeight * 1/3)
    }
}

struct AverageLabelView: View {
    let average: Double
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        Text("AVG: \(String(format: "%.1f", average))g")
            .font(.title3)
            .foregroundStyle(ThemeColor.from(mainColorName).color)
            .padding(.horizontal)
    }
}
