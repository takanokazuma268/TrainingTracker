//
//  PageIndicatorView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/29.
//
import SwiftUI

struct PageIndicatorView: View {
    let selectedTab: Int

    var body: some View {
        HStack {
            Spacer()
            HStack(spacing: AppSpacing.medium) {
                IndicatorCircle(isSelected: selectedTab == 0)
                IndicatorCircle(isSelected: selectedTab == 1)
            }
            Spacer()
        }
    }

    private struct IndicatorCircle: View {
        let isSelected: Bool
        @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

        var body: some View {
            Circle()
                .fill(isSelected ? ThemeColor.from(mainColorName).color : Color.gray.opacity(0.3))
                .frame(width: 10, height: 10)
        }
    }
}
