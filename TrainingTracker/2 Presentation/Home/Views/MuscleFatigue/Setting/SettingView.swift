//
//  SettingView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/08.
//
import SwiftUI

struct SettingView: View {
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        BaseNavigationView {
            VStack(spacing: 16) {
                Text("テーマカラーを選択")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                ForEach(colorOptions, id: \.self) { colorCase in
                    Button(action: {
                        mainColorName = colorCase.rawValue
                    }) {
                        Text(colorCase.rawValue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(colorCase.color)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
        }
    }

    private var colorOptions: [ThemeColor] {
        ThemeColor.allCases
    }
}

#Preview {
    SettingView()
        .environmentObject(NavigationModel())
}
