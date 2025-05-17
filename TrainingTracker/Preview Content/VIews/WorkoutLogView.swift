//
//  WorkoutLogView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI
import SwiftData

struct WorkoutLogView: View {
    @StateObject private var viewModel: WorkoutLogViewModel

    init(workoutCategory: WorkoutCategory, date: Date? = nil) {
        _viewModel = StateObject(wrappedValue: WorkoutLogViewModel(workoutCategory: workoutCategory, date: date))
    }

    @AppStorage("selectedTab") private var selectedTabRawValue: String = "home"

    var selectedTab: ContentView.Tab {
        ContentView.Tab(rawValue: selectedTabRawValue) ?? .home
    }
    var body: some View {
        if viewModel.isHomeView {
            switch selectedTab {
            case .home:
                HomeView()
            case .calendar:
                WorkoutCalendarView()
            case .weight:
                Text("体重記録")
            }
        } else {
            VStack(spacing: 24) {
                
                Text(viewModel.workoutCategory.jaName)
                    .font(.title)
                    .foregroundColor(.yellow)
                    .bold()
                
                HStack {
                    Text("Date")
                        .foregroundColor(.white)
                    DatePicker("", selection: $viewModel.workoutDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    HStack {
                        Text("SET")
                            .frame(width: WorkoutLogConstants.setWidth, alignment: .leading)
                        Spacer()
                        Text("WEIGHT")
                            .frame(width: WorkoutLogConstants.weightWidth, alignment: .leading)
                        Spacer()
                        Text("REPS")
                            .frame(width: WorkoutLogConstants.repsWidth, alignment: .leading)
                    }
                    .foregroundColor(.yellow)
                    .font(.headline)
                    
                    Divider().background(Color.yellow)
                    
                    ForEach($viewModel.sets) { $row in
                        HStack {
                            WorkoutInputRowView(row: $row)
                            Button(action: {
                                viewModel.sets.removeAll { $0.id == row.id }
                                for index in viewModel.sets.indices {
                                    viewModel.sets[index].set = index + 1
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Button(action: {
                        let nextSet = viewModel.sets.count + 1
                        viewModel.sets.append(WorkoutInputRow(set: nextSet))
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Set")
                        }
                        .foregroundColor(.yellow)
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    viewModel.handleSave()
                }) {
                    Text("SAVE")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
                .alert(WorkoutLogConstants.overwriteAlertMessage, isPresented: $viewModel.showOverwriteAlert) {
                    Button("上書き", role: .destructive) {
                        if let existing = viewModel.existingLogToReplace {
                            viewModel.saveWorkout(replacing: existing)
                        }
                    }
                    Button("キャンセル", role: .cancel) {}
                }
                .alert(WorkoutLogConstants.inputErrorAlertMessage, isPresented: $viewModel.showInputErrorAlert) {
                    Button("OK", role: .cancel) {}
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
            .onAppear {
                viewModel.loadLatestWorkoutIfExists()
            }
        }
    }
}

final class WorkoutLogViewModel: ObservableObject {
    let workoutCategory: WorkoutCategory
    @Published var workoutDate: Date = Date()
    @Published var sets: [WorkoutInputRow] = [
        WorkoutInputRow(set: 1),
        WorkoutInputRow(set: 2),
        WorkoutInputRow(set: 3)
    ]
    @Published var isHomeView: Bool = false
    @Published var showOverwriteAlert = false
    @Published var existingLogToReplace: WorkoutLog?
    @Published var showInputErrorAlert = false
    @Environment(\.modelContext) private var modelContext

    init(workoutCategory: WorkoutCategory, date: Date? = nil) {
        self.workoutCategory = workoutCategory
        self.workoutDate = date ?? Date()
        print("📝 WorkoutLogViewModel initialized with category: \(workoutCategory.code), date: \(self.workoutDate)")
    }

    func handleSave() {
        guard isValidInput() else {
            showInputErrorAlert = true
            return
        }

        if let existing = checkForOverwrite() {
            existingLogToReplace = existing
            showOverwriteAlert = true
            return
        }

        saveWorkout()
    }

    func isValidInput() -> Bool {
        sets.contains { Double($0.weight) != nil && Int($0.reps) != nil }
    }

    func checkForOverwrite() -> WorkoutLog? {
        do {
            let logs = try modelContext.fetch(FetchDescriptor<WorkoutLog>())
            return logs.first {
                $0.workoutCode == workoutCategory.code &&
                Calendar.current.isDate($0.date, inSameDayAs: workoutDate)
            }
        } catch {
            print("❌ Failed to fetch logs: \(error)")
            return nil
        }
    }

    func saveWorkout(replacing existing: WorkoutLog? = nil) {
        if let existing = existing {
            modelContext.delete(existing)
        }

        let savedSets = sets.compactMap { row -> WorkoutSet? in
            guard let weight = Double(row.weight),
                  let reps = Int(row.reps) else {
                return nil
            }
            return WorkoutSet(setNumber: row.set, weight: weight, reps: reps)
        }

        let newLog = WorkoutLog(workoutCode: workoutCategory.code, date: workoutDate, sets: savedSets)
        modelContext.insert(newLog)

        do {
            try modelContext.save()
            isHomeView = true
        } catch {
            print("❌ Failed to save workout: \(error)")
        }
    }

    func loadLatestWorkoutIfExists() {
        let context = modelContext
        Task {
            do {
                let logs = try context.fetch(FetchDescriptor<WorkoutLog>())
                if let existing = logs.first(where: {
                    $0.workoutCode == workoutCategory.code &&
                    Calendar.current.isDate($0.date, inSameDayAs: workoutDate)
                }) {
                    DispatchQueue.main.async {
                        self.sets = existing.sets
                            .sorted(by: { $0.setNumber < $1.setNumber })
                            .map {
                                WorkoutInputRow(set: $0.setNumber, weight: String($0.weight), reps: String($0.reps))
                            }
                    }
                }
            } catch {
                print("❌ WorkoutLogの取得に失敗: \(error)")
            }
        }
    }
}

struct WorkoutLogConstants {
    static let overwriteAlertMessage = "既に同じ日のワークアウトが存在します。上書きしますか？"
    static let inputErrorAlertMessage = "重さと回数を入力してください"
    static let setWidth: CGFloat = 40
    static let weightWidth: CGFloat = 80
    static let repsWidth: CGFloat = 80
}

struct WorkoutInputRow: Identifiable {
    let id = UUID()
    var set: Int
    var weight: String = ""
    var reps: String = ""
}

struct WorkoutInputRowView: View {
    @Binding var row: WorkoutInputRow

    var body: some View {
        HStack {
            Text("\(row.set)")
                .frame(width: 35, alignment: .leading)
            Spacer()
            TextField("kg", text: $row.weight)
                .keyboardType(.decimalPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80, alignment: .leading)
            Spacer()
            TextField("reps", text: $row.reps)
                .keyboardType(.numberPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80, alignment: .leading)
        }
        .foregroundColor(.white)
    }
}


#Preview {
    WorkoutLogView(workoutCategory: WorkoutCategory.sampleData().first!)
}
