//
//  MuscleCategory.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/09.
//

import Foundation

struct SubMuscleCategory {
    let code: String
    let jaName: String
    let enName: String
}

struct MainMuscleCategory {
    let code: String
    let jaName: String
    let enName: String
    let subMuscleCategories: [SubMuscleCategory]
    let muscleIllustration: String
}

struct MuscleCategory : Identifiable{
    var id: ObjectIdentifier
    
    static let all: [MainMuscleCategory] = [
        MainMuscleCategory(
            code: "Chest",
            jaName: "胸",
            enName: "Chest",
            subMuscleCategories: [
                SubMuscleCategory(code: "CH_001", jaName: "大胸筋", enName: "Pectoralis Major")
            ],
            muscleIllustration: "front_chest"
        ),
        MainMuscleCategory(
            code: "Back",
            jaName: "背中",
            enName: "Back",
            subMuscleCategories: [
                SubMuscleCategory(code: "BK_001", jaName: "広背筋", enName: "Latissimus Dorsi"),
                SubMuscleCategory(code: "BK_002", jaName: "僧帽筋", enName: "Trapezius"),
                SubMuscleCategory(code: "BK_003", jaName: "脊柱起立筋", enName: "Erector Spinae")
            ],
            muscleIllustration: "back_back"
        ),
        MainMuscleCategory(
            code: "Sholder",
            jaName: "肩",
            enName: "Shoulder",
            subMuscleCategories: [
                SubMuscleCategory(code: "SH_001", jaName: "三角筋前部", enName: "Anterior Deltoid"),
                SubMuscleCategory(code: "SH_002", jaName: "三角筋中部", enName: "Lateral Deltoid"),
                SubMuscleCategory(code: "SH_003", jaName: "三角筋後部", enName: "Posterior Deltoid")
            ],
            muscleIllustration: "front_sholder"
        ),
        MainMuscleCategory(
            code: "ForeArm",
            jaName: "前腕",
            enName: "ForeArm",
            subMuscleCategories: [
                SubMuscleCategory(code: "FA_001", jaName: "前腕筋群", enName: "Forearms")
            ],
            muscleIllustration: "front_forearm"
        ),
        MainMuscleCategory(
            code: "UpperArm",
            jaName: "上腕",
            enName: "UpperArm",
            subMuscleCategories: [
                SubMuscleCategory(code: "UA_001", jaName: "上腕二頭筋", enName: "Biceps"),
                SubMuscleCategory(code: "UA_002", jaName: "上腕三頭筋", enName: "Triceps")
            ],
            muscleIllustration: "front_upperarm"
        ),
        MainMuscleCategory(
            code: "Abs",
            jaName: "腹筋",
            enName: "Abs",
            subMuscleCategories: [
                SubMuscleCategory(code: "AB_001", jaName: "腹直筋", enName: "Rectus Abdominis"),
                SubMuscleCategory(code: "AB_002", jaName: "腹斜筋", enName: "Obliques"),
                SubMuscleCategory(code: "AB_003", jaName: "腹横筋", enName: "Transverse Abdominis")
            ],
            muscleIllustration: "front_abs"
        ),
        MainMuscleCategory(
            code: "Thigh",
            jaName: "太もも",
            enName: "Thigh",
            subMuscleCategories: [
                SubMuscleCategory(code: "TH_001", jaName: "大腿四頭筋", enName: "Quadriceps"),
                SubMuscleCategory(code: "TH_002", jaName: "ハムストリング", enName: "Hamstrings")
            ],
            muscleIllustration: "front_thigh"
        ),
        MainMuscleCategory(
            code: "Glute",
            jaName: "お尻",
            enName: "Glute",
            subMuscleCategories: [
                SubMuscleCategory(code: "GL_001", jaName: "大臀筋", enName: "Gluteus Maximus")
            ],
            muscleIllustration: "back_glute"
        ),
        MainMuscleCategory(
            code: "Calve",
            jaName: "ふくらはぎ",
            enName: "Calve",
            subMuscleCategories: [
                SubMuscleCategory(code: "CA_001", jaName: "腓腹筋", enName: "Gastrocnemius"),
                SubMuscleCategory(code: "CA_002", jaName: "ヒラメ筋", enName: "Soleus")
            ],
            muscleIllustration: "back_calve"
        )
    ]
}

extension MuscleCategory {
    static func findMainCategory(code: String) -> MainMuscleCategory {
        guard let category = all.first(where: { $0.code == code }) else {
            assertionFailure("MainMuscleCategory with code \(code) not found.")
            fatalError("Missing required MainMuscleCategory.")
        }
        return category
    }

    static func findSubCategory(mainCode: String, subCode: String) -> SubMuscleCategory {
        let main = findMainCategory(code: mainCode)
        guard let sub = main.subMuscleCategories.first(where: { $0.code == subCode }) else {
            assertionFailure("SubMuscleCategory with code \(subCode) not found in \(mainCode).")
            fatalError("Missing required SubMuscleCategory.")
        }
        return sub
    }

    // Chest
    static var chest: MainMuscleCategory { findMainCategory(code: "Chest") }
    static var chestSub1: SubMuscleCategory { findSubCategory(mainCode: "Chest", subCode: "CH_001") }

    // Back
    static var back: MainMuscleCategory { findMainCategory(code: "Back") }
    static var backSub1: SubMuscleCategory { findSubCategory(mainCode: "Back", subCode: "BK_001") }
    static var backSub2: SubMuscleCategory { findSubCategory(mainCode: "Back", subCode: "BK_002") }
    static var backSub3: SubMuscleCategory { findSubCategory(mainCode: "Back", subCode: "BK_003") }

    // Sholder
    static var sholder: MainMuscleCategory { findMainCategory(code: "Sholder") }
    static var sholderSub1: SubMuscleCategory { findSubCategory(mainCode: "Sholder", subCode: "SH_001") }
    static var sholderSub2: SubMuscleCategory { findSubCategory(mainCode: "Sholder", subCode: "SH_002") }
    static var sholderSub3: SubMuscleCategory { findSubCategory(mainCode: "Sholder", subCode: "SH_003") }

    // ForeArm
    static var foreArm: MainMuscleCategory { findMainCategory(code: "ForeArm") }
    static var foreArmSub1: SubMuscleCategory { findSubCategory(mainCode: "ForeArm", subCode: "FA_001") }
    static var foreArmSub2: SubMuscleCategory { findSubCategory(mainCode: "ForeArm", subCode: "FA_002") }

    // UpperArm
    static var upperArm: MainMuscleCategory { findMainCategory(code: "UpperArm") }
    static var upperArmSub1: SubMuscleCategory { findSubCategory(mainCode: "UpperArm", subCode: "UA_001") }

    // Abs
    static var abs: MainMuscleCategory { findMainCategory(code: "Abs") }
    static var absSub1: SubMuscleCategory { findSubCategory(mainCode: "Abs", subCode: "AB_001") }
    static var absSub2: SubMuscleCategory { findSubCategory(mainCode: "Abs", subCode: "AB_002") }
    static var absSub3: SubMuscleCategory { findSubCategory(mainCode: "Abs", subCode: "AB_003") }

    // Thigh
    static var thigh: MainMuscleCategory { findMainCategory(code: "Thigh") }
    static var thighSub1: SubMuscleCategory { findSubCategory(mainCode: "Thigh", subCode: "TH_001") }
    static var thighSub2: SubMuscleCategory { findSubCategory(mainCode: "Thigh", subCode: "TH_002") }

    // Glute
    static var glute: MainMuscleCategory { findMainCategory(code: "Glute") }
    static var gluteSub1: SubMuscleCategory { findSubCategory(mainCode: "Glute", subCode: "GL_001") }

    // Calve
    static var calve: MainMuscleCategory { findMainCategory(code: "Calve") }
    static var calveSub1: SubMuscleCategory { findSubCategory(mainCode: "Calve", subCode: "CA_001") }
    static var calveSub2: SubMuscleCategory { findSubCategory(mainCode: "Calve", subCode: "CA_002") }
}
