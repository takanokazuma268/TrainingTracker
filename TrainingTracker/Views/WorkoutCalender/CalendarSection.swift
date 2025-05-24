//
//  ff.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//
import SwiftUI

struct CalendarSection: View {
    @ObservedObject var calendarVM: CalendarViewModel
    let workouts: [WorkoutLog]

    var body: some View {
        VStack(spacing: 12) {
            CalendarHeader(calendarVM: calendarVM)
            WorkoutCalendarGrid(
                vm: calendarVM,
                workouts: workouts,
                onDateSelected: { date in
                    calendarVM.selectedDate = date
                }
            )
        }
    }
}
