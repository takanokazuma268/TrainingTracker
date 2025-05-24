//
//  HomeView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//
import SwiftUI

struct HomeView: View {

    @Binding var path : [Path]

    var body: some View {
        NavigationStack(path: $path){
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 32) {
                    Spacer()
                    
                    Header(text:"TRAINING TRACKER")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        DescriptionText(text:"💪 筋肉の疲労感")
                        MuscleFatiguePager()
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        DescriptionText(text:"🔥 今日のおすすめ")
                        RecommendedMuscleCategoryCard()
                    }
                    
                    TrainingStartButton(action: {
                        path.append(Path.workoutSelection(date: Date()))
                    }, title: "トレーニング開始")
                    
                    Spacer()
                }
            }
            .navigationDestination(for: Path.self) { path in
                path.destinationView(path: $path)
            }
        }
    }
}

//#Preview {
//    HomeView(path: .constant([]))
//}
