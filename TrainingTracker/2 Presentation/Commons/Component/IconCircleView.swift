//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/05.
//
import SwiftUI

struct IconCircleView: View {
    let systemName: String
    let size: CGFloat
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.white, ThemeColor.from(mainColorName).color], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)
            Image(systemName: systemName)
                .foregroundColor(AppColor.black)
                .font(.title2)
        }
    }
}
