//
//  Colors.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/01.
//
import SwiftUI

enum AppColor {
    static let white = Color.white
    static let lightGray = Color(white: 0.85)
    static let darkGray = Color(white: 0.1)
    static let black = Color.black
}

enum AppFont {
    static let title = Font.system(size: 20, weight: .bold)
    static let body = Font.system(size: 16)
    static let caption = Font.system(size: 12)
}

enum AppSpacing {
    static let small: CGFloat = 4
    static let medium: CGFloat = 8
    static let large: CGFloat = 16
}

struct AppCornerRadius {
    static let small: CGFloat = 4
    static let medium: CGFloat = 8
    static let large: CGFloat = 16
}

enum MainColor {
    static let neonYellow = Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
    static let brightGold = Color(red: 230 / 255, green: 190 / 255, blue: 60 / 255)
    static let neonOrange = Color(red: 255 / 255, green: 95 / 255, blue: 31 / 255)
    static let neonGreen = Color(red: 57 / 255, green: 255 / 255, blue: 20 / 255)
    static let neonPink = Color(red: 255 / 255, green: 20 / 255, blue: 147 / 255)
    static let deepGreen = Color(red: 34 / 255, green: 139 / 255, blue: 34 / 255)
    static let neonCyan = Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255)
}

enum ThemeColor: String, CaseIterable {
    case neonYellow, neonOrange, neonGreen, brightGold, neonPink, deepGreen, neonCyan

    var color: Color {
        switch self {
        case .neonYellow: return MainColor.neonYellow
        case .neonOrange: return MainColor.neonOrange
        case .neonGreen: return MainColor.neonGreen
        case .brightGold: return MainColor.brightGold
        case .neonPink: return MainColor.neonPink
        case .deepGreen: return MainColor.deepGreen
        case .neonCyan: return MainColor.neonCyan
        }
    }

    static func from(_ rawValue: String?) -> ThemeColor {
        guard let rawValue, let color = ThemeColor(rawValue: rawValue) else {
            return .brightGold
        }
        return color
    }
}
