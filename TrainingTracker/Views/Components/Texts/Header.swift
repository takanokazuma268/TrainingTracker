//
//  Title.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct Header: View {
    let text: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(text)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.yellow)

            Rectangle()
                .fill(Color.yellow)
                .frame(height: 2)
                .padding(.horizontal, 32)
        }
    }
}
