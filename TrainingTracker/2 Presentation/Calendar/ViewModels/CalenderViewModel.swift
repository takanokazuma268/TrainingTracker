//
//  WorkoutLogViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/23.
//
import Foundation
import SwiftData

final class CalenderViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var selectedMonth: Date = Date()
    @Published var workoutLogs:[WorkoutLog] = []
    @Published var workoutDates: Set<Date> = []
    var calendar = CalendarModel(month: Date())

    private var workoutRepo: WorkoutLogRepo?
    
    func setupRepository(with context: ModelContext) {
        self.workoutRepo = WorkoutLogRepo(context: context)
    }
    
    func loadWorkoutsForSelectedDate() {
        guard let repo = workoutRepo else { return }
        do {
            self.workoutLogs = try repo.fetchByDate(selectedDate)
        } catch {
            print("❌ Failed to load workouts for selected date: \(error)")
            self.workoutLogs = []
        }
    }
    
    func loadWorkoutsForMonth() {
        guard let repo = workoutRepo else { return }
        do {

            let logs = try repo.fetchByMonth(selectedMonth)
            self.workoutDates = Set(logs.map { Calendar.current.startOfDay(for: $0.date) })
        } catch {
            print("❌ Failed to load workouts for month: \(error)")
            self.workoutDates = []
        }
    }

    func isSelectedDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(selectedDate, inSameDayAs: date)
    }

    func hasWorkout(on date: Date) -> Bool {
        return workoutDates.contains(Calendar.current.startOfDay(for: date))
    }
    
    func isWorkoutEmpty() -> Bool {
        return workoutLogs.isEmpty
    }
    
    func delete(_ workoutlog: WorkoutLog) {
        guard let repo = workoutRepo else { return }
        do {
            try repo.delete(workoutlog)
            loadWorkoutsForSelectedDate() // Refresh workouts after deletion
        } catch {
            print("❌ Failed to delete workout set: \(error)")
        }
    }
    
    func changeMonth(by offset: Int){
        self.calendar = calendar.changeMonth(by: offset)
        if let newMonth = Calendar.current.date(byAdding: .month, value: offset, to: selectedMonth),
           let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: newMonth)) {
            self.selectedMonth = startOfMonth
        }
        self.selectedDate = selectedMonth
        loadWorkoutsForMonth()
        loadWorkoutsForSelectedDate()
    }
    
}
