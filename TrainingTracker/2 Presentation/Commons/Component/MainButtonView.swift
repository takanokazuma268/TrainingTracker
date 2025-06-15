//
//  AddButton.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct MainButtonView: View {
    let action: () -> Void
    let title: String
    let iconName: String
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                Text(title)
            }
            .font(.headline)
            .foregroundColor(AppColor.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(ThemeColor.from(mainColorName).color)
            .cornerRadius(AppCornerRadius.large)
        }
    }
}
