//
//  AddButton.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct TrainingStartButton: View {
    let action: () -> Void
    let title: String

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "dumbbell.fill")
                Text(title)
            }
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            .cornerRadius(16)
            .padding(.horizontal, 16)
        }
    }
}
