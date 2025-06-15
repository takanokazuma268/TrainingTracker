//
//  ProteinRingView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import SwiftUI

struct ProteinRingView: View {
    let current: CGFloat
    let goal: CGFloat
    var progress: CGFloat { min(current / goal, 1.0) }
    
    var body: some View {
        let ringColor: Color = {
            switch progress {
            case ..<0.25: return .red
            case ..<0.5: return .orange
            case ..<0.75: return .yellow
            default: return .blue
            }
        }()
        
        ZStack {
            Circle()
                .stroke(AppColor.darkGray, lineWidth: 20)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(AppColor.lightGray, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: AppSpacing.medium) {
                Text("\(Int(current))g")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(ringColor)
                Text("/ \(Int(goal))g")
                    .font(.title2)
                    .foregroundColor(AppColor.lightGray)
            }
        }
        .frame(width: UIScreen.screenWidth * 5.5/10)
    }
}
