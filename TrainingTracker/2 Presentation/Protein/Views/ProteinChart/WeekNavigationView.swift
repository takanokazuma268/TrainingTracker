//
//  WeekNavigationView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import SwiftUI

struct WeekNavigationView: View {
    @ObservedObject var ProteinChartVM: ProteinChartViewModel
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        HStack {
            Button(action: {
                ProteinChartVM.shiftWeek(by: -1)
            }) {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(ProteinChartVM.weekRangeString())

            Spacer()

            Button(action: {
                ProteinChartVM.shiftWeek(by: 1)
            }) {
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(ThemeColor.from(mainColorName).color)
    }
}
