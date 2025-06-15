//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct MuscleFatigueView: View {
    @StateObject private var MuscleFatigueVM = MuscleFatigueViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            PageIndicatorView(selectedTab: selectedTab)
            
            TabView(selection: $selectedTab) {
                if let fatigueList = MuscleFatigueVM.fatigueList {
                    MuscleFatigueIllustrationView(fatigueList: fatigueList)
                        .tag(0)
                    MuscleFatigueListWrapperView(fatigueList: fatigueList)
                        .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .cardStyle()
        .onAppear {
            MuscleFatigueVM.fetch(context: modelContext)
        }
    }
    
    private struct MuscleFatigueListWrapperView: View {
        let fatigueList: MuscleFatigueList

        var body: some View {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    MuscleFatigueListView(fatigueList: fatigueList)
                        .frame(width: geometry.size.width)
                }
            }
        }
    }
}

#Preview {
    MuscleFatigueView()
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
        .background(Color.black.edgesIgnoringSafeArea(.all))
}
