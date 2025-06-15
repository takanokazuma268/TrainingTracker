//
//  TrainingTrackerApp.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//

import SwiftUI
import SwiftData

@main
struct TrainingTrackerApp: App {
    @StateObject private var navigationModel = NavigationModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationModel)
                .onAppear {
                    func loadJSON(resource: String, into loader: (URL) throws -> Void) {
                        if let url = Bundle.main.url(forResource: resource, withExtension: "json") {
                            do {
                                try loader(url)
                            } catch {
                                print("❌ Failed to load \(resource).json:", error)
                            }
                        } else {
                            print("❌ \(resource).json not found")
                        }
                    }

                    loadJSON(resource: "main_muscle", into: MainMuscleCache.shared.load)
                    loadJSON(resource: "sub_muscle", into: SubMuscleCache.shared.load)
                    loadJSON(resource: "workout", into: WorkoutCache.shared.load)
                }
        }
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self, ProteinLog.self])
        
    }
}
