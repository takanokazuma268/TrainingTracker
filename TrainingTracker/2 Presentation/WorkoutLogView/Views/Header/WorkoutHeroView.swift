//
//  TestIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/30.
//

import SwiftUI

struct WorkoutHeroView: View {
    let workout: Workout

    var body: some View {
        ZStack{
            ZStack{
                WorkoutLabelNeon(text: workout.enName)
                    .blur(radius: 10)
                WorkoutLabelNeon(text: workout.enName)
            }
            .frame(maxWidth: UIScreen.screenWidth * 0.9, maxHeight: UIScreen.screenHeight * 0.3, alignment: .leading)
            .overlay(
                RoundedRectangle(cornerRadius: AppCornerRadius.medium)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 5)
            )

            Image(workout.imageName ?? "Unknown")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6)
                .shadow(color: AppColor.darkGray, radius: 30, x: 15, y: 15)
                .offset(x: 90,y: 20)
        }
    }
}

private struct WorkoutLabelNeon: View {
    let text :String
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    var body: some View {
        Text(text)
            .font(.custom("Futura-Bold", size: 80))
            .foregroundColor(AppColor.white)
            .shadow(color: ThemeColor.from(mainColorName).color.opacity(1), radius: 10, x: 0, y: 0)
            .rotation3DEffect(
                .degrees(40),
                axis: (x: 0, y: 1, z: 0),
                anchor: .leading,
                perspective: 0.5
            )
            .fixedSize(horizontal: false, vertical: true)
            .minimumScaleFactor(0.3)
            .lineLimit(2)
            .padding()
    }
}

#Preview {
    let mainMuscle = MainMuscle(
        code: "Back",
        jaName: "背中",
        enName: "Back",
        illustration: "back_back",
        isFront: false
    )

    let subMuscle = SubMuscle(
        code: "BK_003",
        jaName: "脊柱起立筋",
        enName: "Erector Spinae",
        mainMuscleCode: "Back"
    )

    WorkoutHeroView(
        workout: Workout(
            code: "WK_010",
            jaName: "デッドリフト",
            enName: "Cable Crossover",
            imageName: "AB_Crunch",
            mainMuscles: [mainMuscle],
            subMuscles: [subMuscle],
            equipment: ["バーベル"],
            displayPriority: 10
        )
    )
    .background(
        AppColor.black
            .ignoresSafeArea()
    )
}
