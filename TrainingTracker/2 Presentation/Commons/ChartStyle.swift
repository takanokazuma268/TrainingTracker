//
//  ChartStyle.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/08.
//

import SwiftUI
import Charts

struct WorkoutChartStyle: ViewModifier {
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    func body(content: Content) -> some View {
        content
            .chartXAxis {
                AxisMarks(preset: .aligned, position: .bottom) {
                    AxisValueLabel()
                        .foregroundStyle(ThemeColor.from(mainColorName).color)
                }
            }
            .chartYAxis {
                AxisMarks(preset: .extended, position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(AppColor.lightGray)
                    AxisValueLabel()
                        .foregroundStyle(ThemeColor.from(mainColorName).color)
                }
            }
            .chartScrollableAxes(.horizontal)
    }
}

extension View {
    func workoutChartStyle() -> some View {
        self.modifier(WorkoutChartStyle())
    }
}
