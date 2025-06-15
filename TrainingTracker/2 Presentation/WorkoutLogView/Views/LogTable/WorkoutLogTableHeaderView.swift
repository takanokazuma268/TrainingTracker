//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//

import SwiftUI

struct WorkoutLogTableHeaderView: View {
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    var body: some View {
        HStack {
            Text("SET")
                .frame(width: 40, alignment: .leading)
            Spacer()
            Text("WEIGHT")
                .frame(width: 80, alignment: .leading)
            Spacer()
            Text("REPS")
                .frame(width: 80, alignment: .leading)
        }
        .foregroundColor(ThemeColor.from(mainColorName).color)
        .font(.headline)
        Divider().background(ThemeColor.from(mainColorName).color)
    }
}
