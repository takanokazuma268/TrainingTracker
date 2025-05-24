//
//  WorkoutCalendarView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutCalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var calendarVM = CalendarViewModel()
    @State private var selectedWorkout: (WorkoutCategory, Date)? = nil
    @Binding var path: [Path]
    
    let calendar = Calendar.current

    @Query var workouts: [WorkoutLog]

    // Helper to get Japanese workout name from code
    func workoutName(for code: String) -> String {
        WorkoutCategory.sampleData().first(where: { $0.code == code })?.jaName ?? code
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                CalendarSection(calendarVM: calendarVM, workouts: workouts)
                WorkoutListSection(
                    calendarVM: calendarVM,
                    workouts: workouts,
                    workoutName: workoutName,
                    path: $path,
                    modelContext: modelContext
                )
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationDestination(for: Path.self) { path in
                path.destinationView(path: $path)
            }
        }
    }
}


#Preview {
    WorkoutCalendarView(path: .constant([]))
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
}
