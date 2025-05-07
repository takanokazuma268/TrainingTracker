//
//  ContentView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("ホーム")
                }

            WorkoutCalendarView()
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                    Text("筋トレ記録")
                }

            Text("体重記録")
                .tabItem {
                    Image(systemName: "scalemass")
                    Text("体重記録")
                }
        }
    }
}

#Preview {
    ContentView()
}
