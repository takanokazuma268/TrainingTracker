//
//  ContentView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    enum Tab: String, Codable {
        case home
        case calendar
        case weight
    }

    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    @State private var path = [Path]()

    private var selectedTabBinding: Binding<Tab> {
        Binding(
            get: { selectedTab },
            set: {
                selectedTab = $0
                path.removeAll()
            }
        )
    }
    
    var body: some View {
        TabView(selection: selectedTabBinding) {
            HomeView(path: $path)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }
                .tag(Tab.home)

            WorkoutCalendarView(path: $path)
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("筋トレ記録")
                }
                .tag(Tab.calendar)

            Text("体重記録")
                .tabItem {
                    Image(systemName: "scalemass")
                    Text("体重記録")
                }
                .tag(Tab.weight)
        }
        .accentColor(.yellow)
        .navigationTitle("Training Tracker")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
}
