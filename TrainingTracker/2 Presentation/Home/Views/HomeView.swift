//
//  HomeView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    
    @State private var isShowingSettings = false
    var body: some View {
        BaseNavigationView {
            VStack(spacing: 32) {
                HStack{
                    Header(text:"TRAINING TRACKER")
                    
                    
                    Button(action: {
                        isShowingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .foregroundStyle(AppColor.white)
                    }
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    DescriptionText(text:"💪 筋肉の疲労感")
                    MuscleFatigueView()
                }
                
                VStack(alignment: .leading, spacing: AppSpacing.medium) {
                    DescriptionText(text:"🔥 今日のおすすめ")
                    RecommendedView()
                }
                
                MainButtonView(
                    action: {
                        navigationModel.path.append(AppPath.workoutSelection(recordDate: Date()))
                    },
                    title: "トレーニング開始",
                    iconName: "dumbbell.fill"
                )
                .padding(.bottom)
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingView()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(NavigationModel())
}
