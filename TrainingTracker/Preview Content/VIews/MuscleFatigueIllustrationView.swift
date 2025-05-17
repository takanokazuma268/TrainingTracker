import SwiftUI

struct MuscleFatigueIllustrationView: View {
    let fatigueInfoFrontTest: [fatigueInfo] = [
        .init(
            muscleCategory: MuscleCategory.abs,
            fatigueLevel: .low
        ),
        .init(
            muscleCategory: MuscleCategory.chest,
            fatigueLevel: .high
        ),
        .init(
            muscleCategory: MuscleCategory.sholder,
            fatigueLevel: .low
        )

    ]

    let fatigueInfoBackTest: [fatigueInfo] = [
        .init(
            muscleCategory: MuscleCategory.back,
            fatigueLevel: .high
        ),
        .init(
            muscleCategory: MuscleCategory.calve,
            fatigueLevel: .low
        )
    ]

    var body: some View {
        VStack(spacing: 1) {
            HStack {
                MuscleFatigueImage(fatigueInfo: fatigueInfoFrontTest, baseImageName: "front_base")
                MuscleFatigueImage(fatigueInfo: fatigueInfoBackTest, baseImageName: "back_base")
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
    let fatigueInfo: [fatigueInfo]
    let baseImageName: String

    var body: some View {
        ZStack {
            ForEach(fatigueInfo) { info in
                Color(info.fatigueLevel.color)
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

struct fatigueInfo: Identifiable {
    var id: String { muscleCategory.code }
    
    let muscleCategory: MainMuscleCategory
    let fatigueLevel: FatigueLevel
}

#Preview {
    MuscleFatigueIllustrationView()
        .background(Color.black.edgesIgnoringSafeArea(.all))
}
