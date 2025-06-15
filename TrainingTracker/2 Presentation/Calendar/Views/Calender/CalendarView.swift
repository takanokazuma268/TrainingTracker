//
//  WorkoutCalendarGrid.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendarVM: CalenderViewModel
    
    var body: some View {
        VStack{
            CalendarHeader(calendarVM: calendarVM)
            WorkoutCalendarGrid(calendarVM: calendarVM)
        }
    }
}

struct WorkoutCalendarGrid: View {
    @ObservedObject var calendarVM: CalenderViewModel
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(calendarVM.calendar.orderedShortWeekdaySymbols(), id: \.self) { day in
                Text(day)
                    .foregroundColor(ThemeColor.from(mainColorName).color)
                    .font(.caption)
            }

            ForEach(calendarVM.calendar.days, id: \.self) { calendarDay in
                if calendarDay == Date.distantPast {
                    Text("")
                        .frame(maxWidth: .infinity, minHeight: 40)
                } else {
                    Text("\(Calendar.current.component(.day, from: calendarDay))")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            ZStack {
                                if calendarVM.isSelectedDate(calendarDay) {
                                    Circle().fill(ThemeColor.from(mainColorName).color)
                                } else if calendarVM.hasWorkout(on: calendarDay) {
                                    Circle().stroke(ThemeColor.from(mainColorName).color, lineWidth: 1)
                                }
                            }
                        )
                        .foregroundColor(calendarVM.isSelectedDate(calendarDay) ? AppColor.black : AppColor.white)
                        .onTapGesture {
                            calendarVM.selectedDate = calendarDay
                            calendarVM.loadWorkoutsForSelectedDate()
                        }
                }
            }
        }
    }
}

struct CalendarHeader: View {
    @ObservedObject var calendarVM :CalenderViewModel
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    var body: some View {
        HStack {
            Button(action: {
                calendarVM.changeMonth(by: -1)
            }) {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(calendarVM.calendar.formattedMonth())

            Spacer()

            Button(action: {
                calendarVM.changeMonth(by: 1)
            }) {
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(ThemeColor.from(mainColorName).color)
    }
}
