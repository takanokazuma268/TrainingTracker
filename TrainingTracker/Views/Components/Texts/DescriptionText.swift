//
//  DescriptionText.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct DescriptionText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.gray)
            .padding(.horizontal, 16)
    }
}
