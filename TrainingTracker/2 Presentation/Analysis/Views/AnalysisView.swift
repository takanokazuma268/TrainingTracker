//
//  AnalysisView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/02.
//
import SwiftUI
import Charts

struct AnalysisView: View {
    let workout: Workout
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var navigationModel: NavigationModel
    
    @StateObject private var analysisVM = AnalysisViewModel()
    @State private var selectedPeriod: PeriodType = .daily
    let rangeOptions = PeriodType.allCases
    
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("トレーニング分析")
                .font(.title)
                .bold()
                .foregroundColor(ThemeColor.from(mainColorName).color)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Label {
                Text(workout.jaName)
                    .font(.headline)
                    .foregroundColor(AppColor.white)
            } icon: {
                Image(systemName: "dumbbell.fill")
                    .foregroundColor(ThemeColor.from(mainColorName).color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("期間", selection: $selectedPeriod) {
                ForEach(rangeOptions, id: \.self) { period in
                    Text(period.displayName)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedPeriod) {
                analysisVM.updateTotalWeightGraph(for: workout, period: selectedPeriod)
                analysisVM.updateOneRepMaxGraph(for: workout, period: selectedPeriod)
            }
        }
        .padding(.bottom, 16)
    }
    
    private var volumeChartView: some View {
        VStack(alignment: .leading) {
            Text("総重量 (kg)")
                .font(.headline)
                .foregroundColor(ThemeColor.from(mainColorName).color)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                Chart {
                    ForEach(analysisVM.totalWeightGraphData, id: \.label) { record in
                        BarMark(
                            x: .value("Date", record.label),
                            y: .value("Volume", record.value)
                        )
                        .foregroundStyle(Color.yellow)
                        .annotation(position: .top) {
                            Text("\(Int(record.value))")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
                .workoutChartStyle()
                .chartXVisibleDomain(length: 12)
                .chartYScale(domain: 0...800)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .frame(width: UIScreen.main.bounds.width * 1.5)
            }
        }
    }
    
    private var oneRMChartView: some View {
        VStack(alignment: .leading) {
            Text("1RM (kg)")
                .font(.headline)
                .foregroundColor(ThemeColor.from(mainColorName).color)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                Chart {
                    ForEach(analysisVM.oneRepMaxGraphData, id: \.label) { record in
                        BarMark(
                            x: .value("Date", record.label),
                            y: .value("Max", record.value)
                        )
                        .foregroundStyle(Color.yellow)
                        .annotation(position: .top) {
                            Text("\(Int(record.value))")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
                .workoutChartStyle()
                .chartXVisibleDomain(length: 12)
                .frame(height: UIScreen.main.bounds.height / 3.5)
                .frame(width: UIScreen.main.bounds.width * 1.5)
            }
        }
    }

    var body: some View {
        BaseNavigationView {
            VStack {
                headerView
                volumeChartView
                oneRMChartView
                Spacer()
            }
            .onAppear {
                analysisVM.setupRepo(context: modelContext)
                analysisVM.updateTotalWeightGraph(for: workout, period: selectedPeriod)
                analysisVM.updateOneRepMaxGraph(for: workout, period: selectedPeriod)
            }
            .padding()
        }
    }
}


#Preview {
    let sampleWorkout = Workout(
        code: "WK_01",
        jaName: "ベンチプレス",
        enName: "Bench Press",
        imageName: "UA_Dips",
        mainMuscles: [],
        subMuscles: [],
        equipment: ["ベンチ", "バーベル"],
        displayPriority: 1
    )
    
    AnalysisView(workout: sampleWorkout)
}


struct WorkoutRecord: Identifiable {
    let id = UUID()
    let date: String
    let value: Double
}

let sampleVolumeData: [WorkoutRecord] = [
    WorkoutRecord(date: "5/26", value: 480),
    WorkoutRecord(date: "5/27", value: 500),
    WorkoutRecord(date: "5/28", value: 520),
    WorkoutRecord(date: "5/29", value: 550),
    WorkoutRecord(date: "5/30", value: 600),
    WorkoutRecord(date: "5/31", value: 620),
    WorkoutRecord(date: "6/1", value: 650),
    WorkoutRecord(date: "6/2", value: 670),
    WorkoutRecord(date: "6/3", value: 690),
    WorkoutRecord(date: "6/4", value: 710),
    WorkoutRecord(date: "6/5", value: 730),
    WorkoutRecord(date: "6/6", value: 750)
]

let sampleMaxData: [WorkoutRecord] = [
    WorkoutRecord(date: "5/26", value: 78),
    WorkoutRecord(date: "5/27", value: 80),
    WorkoutRecord(date: "5/28", value: 82),
    WorkoutRecord(date: "5/29", value: 83),
    WorkoutRecord(date: "5/30", value: 84),
    WorkoutRecord(date: "5/31", value: 85),
    WorkoutRecord(date: "6/1", value: 86),
    WorkoutRecord(date: "6/2", value: 87),
    WorkoutRecord(date: "6/3", value: 88),
    WorkoutRecord(date: "6/4", value: 89),
    WorkoutRecord(date: "6/5", value: 90),
    WorkoutRecord(date: "6/6", value: 91)
]
