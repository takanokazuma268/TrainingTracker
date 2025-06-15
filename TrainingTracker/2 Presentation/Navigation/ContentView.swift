//
//  ContentView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//
import SwiftUI

struct ContentView: View {
    enum Tab: String, Codable {
        case home
        case calendar
        case analysis
        case protein
    }

    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    @EnvironmentObject var navigationModel: NavigationModel
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    private var selectedTabBinding: Binding<Tab> {
        Binding(
            get: { selectedTab },
            set: {
                selectedTab = $0
            }
        )
    }
    
    var body: some View {
        TabView(selection: selectedTabBinding) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
                .tag(Tab.home)

            WorkoutCalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("カレンダー")
                }
                .tag(Tab.calendar)

            WorkoutSelectionView(passedDate: Date())
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("筋トレ分析")
                }
                .tag(Tab.analysis)

            ProteinView()
                .tabItem {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                    Text("タンパク質")
                }
                .tag(Tab.protein)
        }
        .onChange(of: selectedTab) {
            navigationModel.path = NavigationPath()
        }
        .accentColor(ThemeColor.from(mainColorName).color)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
        .environmentObject(NavigationModel())
}
