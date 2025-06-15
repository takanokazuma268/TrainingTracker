//
//  BaseScreenModifier.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/01.
//
import SwiftUI

extension View {
    func baseScreenStyle() -> some View {
        self
            .padding(.horizontal, AppSpacing.medium)
            .background(
                AppColor.black
                    .ignoresSafeArea()
            )
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(AppColor.darkGray)
            .cornerRadius(AppCornerRadius.large)
    }
}

extension UIScreen {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
