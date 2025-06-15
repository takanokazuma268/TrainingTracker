//
//  MuscleFatigueImageView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/25.
//

import SwiftUI

struct MuscleFatigueImage: View {
    let muscleFatigueList: MuscleFatigueList
    let baseImageName: String

    var body: some View {
        ZStack {
            ForEach(muscleFatigueList.all(), id: \.mainMuscle.code) { muscleFatigue in
                Color(muscleFatigue.level.color)
                    .mask(
                        Image(muscleFatigue.mainMuscle.illustration)
                            .resizable()
                            .scaledToFit()
                    )
                    .compositingGroup()
            }

            Image(baseImageName)
                .resizable()
                .scaledToFit()
        }
        .frame(width: UIScreen.main.bounds.width / 3)
        .padding([.leading, .trailing])
    }
}

extension FatigueLevel {
    var color: Color {
        switch self {
        case .high: return .red
        case .low:  return .yellow
        case .none: return .clear
        }
    }
}

