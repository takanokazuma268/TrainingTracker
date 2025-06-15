//
//  Title.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct Header: View {
    let text: String
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        VStack(spacing: AppSpacing.small) {
            Text(text)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(ThemeColor.from(mainColorName).color)

            Rectangle()
                .fill(ThemeColor.from(mainColorName).color)
                .frame(height: 2)
                .padding(.horizontal)
        }
    }
}
