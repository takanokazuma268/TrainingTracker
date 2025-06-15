//
//  SubBottonView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//

import SwiftUI

struct YellowActionButton: View {
    let title: String
    let action: () -> Void
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        Button(title, action: action)
            .font(.headline)
            .foregroundColor(AppColor.black)
            .padding()
            .frame(width: UIScreen.main.bounds.width / 3)
            .background(ThemeColor.from(mainColorName).color)
            .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.medium))
    }
}

