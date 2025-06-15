//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct RecommendedView: View {
    var body: some View {
        HStack() {
            ZStack {
                IconCircleView(systemName: "flame.fill", size: 48)
                Image(systemName: "flame.fill")
                    .foregroundColor(AppColor.black)
                    .font(.title2)
            }
            
            Text("胸・肩・三頭筋")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppColor.white)
            
            Spacer()
        }
        .cardStyle()
    }
}
