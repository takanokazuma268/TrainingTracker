//
//  HomeView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//
import SwiftUI
// HomeView.swift
struct HomeView: View {

    @State private var isWorkoutSelectionView: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if isWorkoutSelectionView {
                WorkoutSelectionView()
            } else {
                VStack(spacing: 32) {
                    Spacer().frame(height: 10)
                    VStack(spacing: 4) {
                        Text("TRAINING TRACKER")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                        Rectangle()
                            .fill(Color.yellow)
                            .frame(height: 2)
                            .padding(.horizontal, 32)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("💪 筋肉の疲労感")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 16)

                        TabView {
                            MuscleFatigueIllustrationView()

                            GeometryReader { geometry in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    MuscleFatigueListView()
                                        .frame(width: geometry.size.width)
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 350)

                    // 今日のおすすめメニュー (Modern Card Style)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("🔥 今日のおすすめ")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 16)

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

                    Button(action: {
                        isWorkoutSelectionView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "dumbbell.fill")
                            Text("トレーニング開始")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                    }

                    Spacer()
                }
            }
            
        }
        
    }
    
    
}

#Preview {
    HomeView()
}
