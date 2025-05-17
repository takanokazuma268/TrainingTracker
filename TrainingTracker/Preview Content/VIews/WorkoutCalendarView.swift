//
//  WorkoutCalendarView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutCalendarView: View {
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    @State private var selectedWorkout: (WorkoutCategory, Date)? = nil
    @State private var showWorkoutSelection = false

    let calendar = Calendar.current

    @Query var workouts: [WorkoutLog]

    // Helper to get Japanese workout name from code
    func workoutName(for code: String) -> String {
        WorkoutCategory.sampleData().first(where: { $0.code == code })?.jaName ?? code
    }

    var body: some View {
        if showWorkoutSelection {
            WorkoutSelectionView()
        } else if let (workout, date) = selectedWorkout {
            WorkoutLogView(workoutCategory: workout, date: date)
        } else {
            VStack(spacing: 20) {
                monthHeader
                calendarGrid
                workoutListSection
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }

    private var monthHeader: some View {
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
    }

    private var calendarGrid: some View {
        let days = generateDays(for: currentMonth)
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            let weekdaySymbols = calendar.shortWeekdaySymbols
            let firstWeekdayIndex = calendar.firstWeekday - 1
            let orderedWeekdays = Array(weekdaySymbols[firstWeekdayIndex...] + weekdaySymbols[..<firstWeekdayIndex])
            ForEach(orderedWeekdays, id: \.self) { day in
                Text(day)
                    .foregroundColor(.yellow)
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
    }

    private var workoutListSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            let todayWorkouts = workouts.filter {
                calendar.isDate($0.date, inSameDayAs: selectedDate)
            }

            if todayWorkouts.isEmpty {
                Text("No workouts recorded.")
                    .foregroundColor(.gray)
            } else {
                ScrollView {
                    ForEach(Array(todayWorkouts.enumerated()), id: \.element.id) { index, workout in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 48, height: 48)
                                Image(systemName: "dumbbell.fill")
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(workoutName(for: workout.workoutCode))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        if let workoutCategory = WorkoutCategory.sampleData().first(where: { $0.code == workout.workoutCode }) {
                                            selectedWorkout = (workoutCategory, selectedDate)
                                        }
                                    }

                                ForEach(workout.sets.sorted(by: { $0.setNumber < $1.setNumber })) { set in
                                    Text(String(format: "Set %d: %.1fkg × %d回", set.setNumber, set.weight, set.reps))
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }
                            }

                            Spacer()
                        
                        Button(action: {
                            print("🗑️ Deleting workout with code: \(workout.workoutCode)")
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .offset(y: CGFloat(index) * -12)
                    }
                }
                .frame(height: 320)
            }

            Button(action: {
                showWorkoutSelection = true
            }) {
                Text("＋ トレーニングを追加")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding(.top, 8)
            }
            .padding(.horizontal)
        }
        .padding()
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

#Preview {
    WorkoutCalendarView()
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self])
}
