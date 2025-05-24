import SwiftUI

struct MuscleFatigueIllustrationView: View {
    
    let fatigueDataList: [FatigueInfo]
    
    var fatigueInfoFront: [FatigueInfo] {
        fatigueDataList.filter { $0.muscleCategory.isFront }
    }
    
    var fatigueInfoBack: [FatigueInfo] {
        fatigueDataList.filter { !$0.muscleCategory.isFront }
    }

    var body: some View {
        VStack(spacing: 1) {
            HStack {
                MuscleFatigueImage(fatigueInfo: fatigueInfoFront, baseImageName: "front_base")
                MuscleFatigueImage(fatigueInfo: fatigueInfoBack, baseImageName: "back_base")
            }
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                    Text("：0〜1日前")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 12, height: 12)
                    Text("：2日前")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.bottom, 8)
    }
}

enum FatigueLevel {
    case high   // 🔴
    case low    // 🟡

    var color: Color {
        switch self {
        case .high: .red
        case .low: .yellow
        }
    }
}

struct MuscleFatigueImage: View {
    let fatigueInfo: [FatigueInfo]
    let baseImageName: String

    var body: some View {
        ZStack {
            ForEach(fatigueInfo) { info in
                Color(info.level.color)
                    .mask(
                        Image(info.muscleCategory.muscleIllustration)
                            .resizable()
                            .scaledToFit()
                    )
                    .compositingGroup()
            }

            Image(baseImageName)
                .resizable()
                .scaledToFit()
        }
        .frame(height: 300)
    }
}


