//
//  WorkoutCalendarView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI

struct WorkoutCalendarView: View {
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()

    let calendar = Calendar.current

    // 仮の筋トレ記録
    let workouts: [Workout] = [
        Workout(name: "Squat", sets: "3 x 100kg", date: Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 7))!),
        Workout(name: "Deadlift", sets: "3 x 120kg", date: Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 14))!),
        Workout(name: "Bench Press", sets: "4 x 90kg", date: Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 21))!)
    ]

    var body: some View {
        VStack(spacing: 20) {
            // 🗓 月の切り替え
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.yellow)
                }

                Spacer()

                Text(monthYearString(from: currentMonth))
                    .foregroundColor(.yellow)
                    .font(.title2.bold())

                Spacer()

                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.horizontal)

            // 📆 カレンダー（日付一覧）
            let days = generateDays(for: currentMonth)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                let weekdaySymbols = calendar.shortWeekdaySymbols
                let firstWeekdayIndex = calendar.firstWeekday - 1
                let orderedWeekdays = Array(weekdaySymbols[firstWeekdayIndex...] + weekdaySymbols[..<firstWeekdayIndex])
                ForEach(orderedWeekdays, id: \.self) { day in
                    Text(day)
                        .foregroundColor(.blue)
                        .font(.caption)
                }

                ForEach(days, id: \.self) { date in
                    let hasWorkout = workouts.contains { calendar.isDate($0.date, inSameDayAs: date) }
                    let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)

                    Text(date == Date.distantPast ? "" : "\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            ZStack {
                                if isSelected {
                                    Circle().fill(Color.yellow)
                                } else if hasWorkout {
                                    Circle().stroke(Color.yellow, lineWidth: 1)
                                }
                            }
                        )
                        .foregroundColor(isSelected ? .black : .white)
                        .onTapGesture {
                            selectedDate = date
                        }
                }
            }
            .padding(.horizontal)

            // 🏋️‍♂️ ワークアウト記録
            VStack(alignment: .leading, spacing: 16) {
                let todayWorkouts = workouts.filter {
                    calendar.isDate($0.date, inSameDayAs: selectedDate)
                }

                if todayWorkouts.isEmpty {
                    Text("No workouts recorded.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(todayWorkouts) { workout in
                        HStack {
                            Text(workout.name)
                                .foregroundColor(.yellow)
                            Spacer()
                            Text(workout.sets)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                    }
                }
            }
            .padding()

            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    // 🔁 月の変更
    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    // 📅 表示用の日付配列生成（1か月分＋先頭の空白を考慮）
    func generateDays(for month: Date) -> [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: month),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))
        else { return [] }

        var days: [Date] = []

        // Find the weekday index for the first day (Sunday = 1, Saturday = 7)
        let weekdayOfFirst = calendar.component(.weekday, from: firstDayOfMonth)

        // Calculate number of leading empty days (e.g., Sunday = 1, so 0; Monday = 2, so 1)
        let leadingEmptyDays = weekdayOfFirst - calendar.firstWeekday
        let emptyDays = (leadingEmptyDays + 7) % 7

        // Append empty placeholders for days before the 1st
        for _ in 0..<emptyDays {
            days.append(Date.distantPast)
        }

        // Append actual dates of the month
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }

        return days
    }

    func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
}

struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let sets: String
    let date: Date
}

#Preview {
    WorkoutCalendarView()
}
