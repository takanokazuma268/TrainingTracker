//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct MuscleFatiguePager: View {
    @StateObject private var viewModel: MuscleFatiguePagerViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0
    
    init() {
        _viewModel = StateObject(wrappedValue: MuscleFatiguePagerViewModel(modelContext: nil))
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MuscleFatigueIllustrationView(fatigueDataList: viewModel.fatigueDataList)
                    .tag(0)
                GeometryReader { geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        MuscleFatigueListView(fatigueDataList: viewModel.fatigueDataList)
                            .frame(width: geometry.size.width)
                    }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(Color.white.opacity(0.1))
            .cornerRadius(16)
            .padding(.horizontal, 16)
            
            VStack {
                HStack {
                    Spacer()
                    HStack(spacing: 12) {
                        Circle()
                            .fill(selectedTab == 0 ? Color.yellow : Color.gray.opacity(0.3))
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(selectedTab == 1 ? Color.yellow : Color.gray.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                    Spacer()
                }
                .padding(.top, 10)

                Spacer()
            }


        }
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.createData()
        }
    }
}

#Preview {
    MuscleFatiguePager()
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
        .background(Color.black.edgesIgnoringSafeArea(.all))
}
