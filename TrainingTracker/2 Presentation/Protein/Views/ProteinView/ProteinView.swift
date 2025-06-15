//
//  ProteinView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/02.
//

import SwiftUI
import Foundation

struct ProteinView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Environment(\.modelContext) private var modelContext
    @StateObject private var ProteinVM = ProteinViewModel()
    
    @AppStorage("proteinGoal") private var goal: Double = 100
    @State private var isShowingGoalSetting = false
    
    var body: some View {
        BaseNavigationView{
            VStack {
                Spacer()
                ProteinRingView(current: CGFloat(ProteinVM.sum), goal: CGFloat(goal))
                    .padding(.top)
                
                ProteinLogListView(logs: ProteinVM.record, onDelete: { log in
                    ProteinVM.delete(log: log)
                })
                ProteinInputForm(ProteinVM: ProteinVM)
                    .padding(.bottom)
                
            }
            .onAppear {
                ProteinVM.setupRepository(with: modelContext)
                ProteinVM.fetchByDate(for: Date())
                ProteinVM.totalAmountByDate(for: Date())
            }
            .toolbar {
                ProteinToolbarButtons(isShowingGoalSetting: $isShowingGoalSetting)
            }
            .sheet(isPresented: $isShowingGoalSetting) {
                ProteinGoalSettingView()
            }
        }
    }
}



struct ProteinToolbarButtons: ToolbarContent {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var isShowingGoalSetting: Bool

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {
                navigationModel.path.append(AppPath.proteinChar)
            }) {
                Image(systemName: "clock.arrow.circlepath")
                    .foregroundColor(.white)
            }

            Button(action: {
                isShowingGoalSetting = true
            }) {
                Image(systemName: "gearshape")
                    .foregroundColor(.white)
            }
        }
    }
}


#Preview {
    ProteinView()
        .environmentObject(NavigationModel())
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self, ProteinLog.self])
}
