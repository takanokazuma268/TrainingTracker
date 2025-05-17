//
//  TrainingTrackerApp.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI

@main
struct TrainingTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
    }
}
