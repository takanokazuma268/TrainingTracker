//
//  WorkoutCategory.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/09.
//
import Foundation

struct WorkoutCategory: Identifiable {
    let code: String
    let jaName: String
    let enName: String
    let imageName: String?
    let mainCategories: [MainMuscleCategory]
    let subCategories: [SubMuscleCategory]
    let equipment: [String]?
    let displayPriority: Int

    var id: String { code }
}

extension WorkoutCategory {
    static func sampleData() -> [WorkoutCategory] {
        return [
            WorkoutCategory(
                code: "WK_001",
                jaName: "ベンチプレス",
                enName: "Bench Press",
                imageName: "CH_BenchPress",
                mainCategories: [MuscleCategory.chest],
                subCategories: [MuscleCategory.chestSub1],
                equipment: ["バーベル", "ベンチ"],
                displayPriority: 1
            ),
            WorkoutCategory(
                code: "WK_002",
                jaName: "ダンベルフライ",
                enName: "Dumbbell Fly",
                imageName: nil,
                mainCategories: [MuscleCategory.chest],
                subCategories: [MuscleCategory.chestSub1],
                equipment: ["ダンベル"],
                displayPriority: 2
            ),
            WorkoutCategory(
                code: "WK_003",
                jaName: "チェストプレス",
                enName: "Chest Press",
                imageName: "CH_ChestPress",
                mainCategories: [MuscleCategory.chest],
                subCategories: [MuscleCategory.chestSub1],
                equipment: ["マシン"],
                displayPriority: 3
            ),
            WorkoutCategory(
                code: "WK_004",
                jaName: "インクラインベンチプレス",
                enName: "Incline Bench Press",
                imageName: nil,
                mainCategories: [MuscleCategory.chest],
                subCategories: [MuscleCategory.chestSub1],
                equipment: ["バーベル"],
                displayPriority: 4
            ),
            WorkoutCategory(
                code: "WK_005",
                jaName: "プッシュアップ",
                enName: "Push-up",
                imageName: nil,
                mainCategories: [MuscleCategory.chest],
                subCategories: [MuscleCategory.chestSub1],
                equipment: ["自重"],
                displayPriority: 5
            ),
            WorkoutCategory(
                code: "WK_006",
                jaName: "デッドリフト",
                enName: "Deadlift",
                imageName: "TH_DeadLift",
                mainCategories: [
                    MuscleCategory.back,
                    MuscleCategory.thigh,
                    MuscleCategory.abs
                ],
                subCategories: [
                    MuscleCategory.backSub1,
                    MuscleCategory.thighSub2,
                    MuscleCategory.absSub1
                ],
                equipment: ["バーベル"],
                displayPriority: 6
            ),
            WorkoutCategory(
                code: "WK_007",
                jaName: "ラットプルダウン",
                enName: "Lat Pulldown",
                imageName: nil,
                mainCategories: [MuscleCategory.back],
                subCategories: [MuscleCategory.backSub1],
                equipment: ["マシン"],
                displayPriority: 7
            ),
            WorkoutCategory(
                code: "WK_008",
                jaName: "プルアップ",
                enName: "Pull-up",
                imageName: nil,
                mainCategories: [
                    MuscleCategory.back,
                    MuscleCategory.foreArm
                ],
                subCategories: [
                    MuscleCategory.backSub1,
                    MuscleCategory.foreArmSub1
                ],
                equipment: ["自重"],
                displayPriority: 8
            ),
            WorkoutCategory(
                code: "WK_009",
                jaName: "シーテッドロー",
                enName: "Seated Row",
                imageName: nil,
                mainCategories: [MuscleCategory.back],
                subCategories: [MuscleCategory.backSub1],
                equipment: ["マシン"],
                displayPriority: 9
            ),
            WorkoutCategory(
                code: "WK_010",
                jaName: "Tバーロウ",
                enName: "T-Bar Row",
                imageName: nil,
                mainCategories: [MuscleCategory.back],
                subCategories: [MuscleCategory.backSub1],
                equipment: ["バー", "プレート"],
                displayPriority: 10
            ),
            WorkoutCategory(
                code: "WK_011",
                jaName: "ショルダープレス",
                enName: "Shoulder Press",
                imageName: "Sh_SholderPress",
                mainCategories: [MuscleCategory.sholder],
                subCategories: [MuscleCategory.sholderSub2],
                equipment: ["ダンベル"],
                displayPriority: 11
            ),
            WorkoutCategory(
                code: "WK_012",
                jaName: "サイドレイズ",
                enName: "Side Lateral Raise",
                imageName: nil,
                mainCategories: [MuscleCategory.sholder],
                subCategories: [MuscleCategory.sholderSub2],
                equipment: ["ダンベル"],
                displayPriority: 12
            ),
            WorkoutCategory(
                code: "WK_013",
                jaName: "フロントレイズ",
                enName: "Front Raise",
                imageName: nil,
                mainCategories: [MuscleCategory.sholder],
                subCategories: [MuscleCategory.sholderSub1],
                equipment: ["ダンベル"],
                displayPriority: 13
            ),
            WorkoutCategory(
                code: "WK_014",
                jaName: "リアレイズ",
                enName: "Rear Delt Raise",
                imageName: nil,
                mainCategories: [MuscleCategory.sholder],
                subCategories: [MuscleCategory.sholderSub3],
                equipment: ["ダンベル"],
                displayPriority: 14
            ),
            WorkoutCategory(
                code: "WK_015",
                jaName: "アーノルドプレス",
                enName: "Arnold Press",
                imageName: nil,
                mainCategories: [MuscleCategory.sholder],
                subCategories: [MuscleCategory.sholderSub2],
                equipment: ["ダンベル"],
                displayPriority: 15
            ),
            WorkoutCategory(
                code: "WK_016",
                jaName: "アームカール",
                enName: "Arm Curl",
                imageName: nil,
                mainCategories: [MuscleCategory.foreArm],
                subCategories: [MuscleCategory.foreArmSub1],
                equipment: ["ダンベル"],
                displayPriority: 16
            ),
            WorkoutCategory(
                code: "WK_017",
                jaName: "コンセントレーションカール",
                enName: "Concentration Curl",
                imageName: nil,
                mainCategories: [MuscleCategory.foreArm],
                subCategories: [MuscleCategory.foreArmSub1],
                equipment: ["ダンベル"],
                displayPriority: 17
            ),
            WorkoutCategory(
                code: "WK_018",
                jaName: "ハンマーカール",
                enName: "Hammer Curl",
                imageName: nil,
                mainCategories: [MuscleCategory.foreArm],
                subCategories: [MuscleCategory.foreArmSub1],
                equipment: ["ダンベル"],
                displayPriority: 18
            ),
            WorkoutCategory(
                code: "WK_019",
                jaName: "トライセップスエクステンション",
                enName: "Triceps Extension",
                imageName: nil,
                mainCategories: [MuscleCategory.foreArm],
                subCategories: [MuscleCategory.foreArmSub2],
                equipment: ["ケーブル"],
                displayPriority: 19
            ),
            WorkoutCategory(
                code: "WK_020",
                jaName: "キックバック",
                enName: "Triceps Kickback",
                imageName: nil,
                mainCategories: [MuscleCategory.foreArm],
                subCategories: [MuscleCategory.foreArmSub2],
                equipment: ["ダンベル"],
                displayPriority: 20
            ),
            WorkoutCategory(
                code: "WK_021",
                jaName: "スクワット",
                enName: "Squat",
                imageName: nil,
                mainCategories: [
                    MuscleCategory.thigh,
                    MuscleCategory.abs
                ],
                subCategories: [
                    MuscleCategory.thighSub1,
                    MuscleCategory.absSub1
                ],
                equipment: ["バーベル"],
                displayPriority: 21
            ),
            WorkoutCategory(
                code: "WK_022",
                jaName: "レッグプレス",
                enName: "Leg Press",
                imageName: nil,
                mainCategories: [MuscleCategory.thigh],
                subCategories: [MuscleCategory.thighSub1],
                equipment: ["マシン"],
                displayPriority: 22
            ),
            WorkoutCategory(
                code: "WK_023",
                jaName: "ランジ",
                enName: "Lunge",
                imageName: nil,
                mainCategories: [MuscleCategory.thigh],
                subCategories: [MuscleCategory.thighSub1],
                equipment: ["ダンベル"],
                displayPriority: 23
            ),
            WorkoutCategory(
                code: "WK_024",
                jaName: "レッグカール",
                enName: "Leg Curl",
                imageName: nil,
                mainCategories: [MuscleCategory.thigh],
                subCategories: [MuscleCategory.thighSub2],
                equipment: ["マシン"],
                displayPriority: 24
            ),
            WorkoutCategory(
                code: "WK_025",
                jaName: "カーフレイズ",
                enName: "Calf Raise",
                imageName: nil,
                mainCategories: [MuscleCategory.calve],
                subCategories: [MuscleCategory.calveSub1],
                equipment: ["自重", "ダンベル"],
                displayPriority: 25
            ),
            WorkoutCategory(
                code: "WK_026",
                jaName: "プランク",
                enName: "Plank",
                imageName: nil,
                mainCategories: [MuscleCategory.abs],
                subCategories: [MuscleCategory.absSub1],
                equipment: ["自重"],
                displayPriority: 26
            ),
            WorkoutCategory(
                code: "WK_027",
                jaName: "クランチ",
                enName: "Crunch",
                imageName: "AB_Crunch",
                mainCategories: [MuscleCategory.abs],
                subCategories: [MuscleCategory.absSub1],
                equipment: ["マット"],
                displayPriority: 27
            ),
            WorkoutCategory(
                code: "WK_028",
                jaName: "シットアップ",
                enName: "Sit-up",
                imageName: nil,
                mainCategories: [MuscleCategory.abs],
                subCategories: [MuscleCategory.absSub1],
                equipment: ["マット"],
                displayPriority: 28
            ),
            WorkoutCategory(
                code: "WK_029",
                jaName: "レッグレイズ",
                enName: "Leg Raise",
                imageName: nil,
                mainCategories: [MuscleCategory.abs],
                subCategories: [MuscleCategory.absSub1],
                equipment: ["自重"],
                displayPriority: 29
            ),
            WorkoutCategory(
                code: "WK_030",
                jaName: "バイシクルクランチ",
                enName: "Bicycle Crunch",
                imageName: nil,
                mainCategories: [MuscleCategory.abs],
                subCategories: [MuscleCategory.absSub1],
                equipment: ["自重"],
                displayPriority: 30
            )
        ]
    }
}
