//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct RecommendedMuscleCategoryCard: View {
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 48, height: 48)
                Image(systemName: "flame.fill")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("胸・肩・三頭筋")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }
}
