//
//  WorkoutCalendarView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutCalendarView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Environment(\.modelContext) private var modelContext
    @StateObject private var calenderVM = CalenderViewModel()

    var body: some View {
        BaseNavigationView {
            VStack(spacing: 20) {
                
                CalendarView(calendarVM: calenderVM)
                
                WorkoutListSection(calenderVM: calenderVM)

                Spacer()

                MainButtonView(
                    action: {
                        navigationModel.path.append(AppPath.workoutSelection(recordDate: calenderVM.selectedDate))
                    },
                    title: "トレーニングを追加",
                    iconName: "plus.circle.fill"
                )
                .padding(.bottom)
            }
            .onAppear {
                calenderVM.setupRepository(with: modelContext)
                calenderVM.loadWorkoutsForSelectedDate()
                calenderVM.loadWorkoutsForMonth()
            }
        }
    }
}
