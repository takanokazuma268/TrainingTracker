//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//
import SwiftUI

struct ProteinCalculationInput {
    var weight: Double?
    var sex: Sex = .男性
    var age: Int? = nil
    var activityLevel: ActivityLevel = .中
    var goal: Goal = .筋肥大
}

struct ProteinGoalSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var navigationModel: NavigationModel
    @AppStorage("proteinGoal") private var proteinGoal: Double = 100
    @State private var draftGoal: Double
    @State private var showDetails: Bool = false
    @State private var input = ProteinCalculationInput()
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue

    init() {
        _draftGoal = State(initialValue: UserDefaults.standard.double(forKey: "proteinGoal"))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Label("1日の目標量を設定", systemImage: "pencil")
                            .font(.title)
                            .bold()
                            .foregroundColor(ThemeColor.from(mainColorName).color)

                        TextField("目標 (g)", value: $draftGoal, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.title2)
                            .frame(height: 50)
                    }

                    YellowActionButton(title: "保存する") {
                        proteinGoal = draftGoal
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    Button(showDetails ? "閉じる" : "計算機能を使用する") {
                        withAnimation {
                            showDetails.toggle()
                        }
                    }
                    .buttonStyle(.bordered)

                    if showDetails {
                        Group {
                            HStack {
                                Label("体重 (kg)", systemImage: "scalemass")
                                Text("必須").foregroundColor(ThemeColor.from(mainColorName).color).font(.caption)
                            }
                            .font(.headline)
                            .foregroundColor(.white)

                            TextField("例: 60", value: Binding(
                                get: { input.weight ?? 0 },
                                set: { input.weight = $0 }
                            ), formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                            HStack {
                                Label("性別", systemImage: "figure.stand")
                                Text("必須").foregroundColor(ThemeColor.from(mainColorName).color).font(.caption)
                            }
                            .font(.headline)
                            .foregroundColor(.white)

                            Picker("性別", selection: $input.sex) {
                                ForEach(Sex.allCases, id: \.self) { sex in
                                    Text(sex.rawValue)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())

                            Divider()
                                .background(ThemeColor.from(mainColorName).color)

                            Group {
                                HStack {
                                    Label("年齢", systemImage: "calendar")
                                    Text("任意").foregroundColor(AppColor.lightGray).font(.caption)
                                }
                                .font(.headline)
                                .foregroundColor(.white)

                                TextField("例: 30", value: Binding(
                                    get: { input.age ?? 0 },
                                    set: { input.age = $0 }
                                ), formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                                HStack {
                                    Label("活動レベル", systemImage: "flame.fill")
                                    Text("任意").foregroundColor(AppColor.lightGray).font(.caption)
                                }
                                .font(.headline)
                                .foregroundColor(.white)

                                Picker("活動レベル", selection: $input.activityLevel) {
                                    ForEach(ActivityLevel.allCases, id: \.self) { level in
                                        Text(level.rawValue)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())

                                HStack {
                                    Label("目標", systemImage: "target")
                                    Text("任意").foregroundColor(AppColor.lightGray).font(.caption)
                                }
                                .font(.headline)
                                .foregroundColor(.white)

                                Picker("目標", selection: $input.goal) {
                                    ForEach(Goal.allCases, id: \.self) { goal in
                                        Text(goal.rawValue)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())

                                YellowActionButton(title: "計算して設定") {
                                    guard let w = input.weight else { return }
                                    let calculated: Double
                                    if let age = input.age {
                                        calculated = ProteinIntakeCalculator.calculateDetailedGoal(
                                            weight: w,
                                            sex: input.sex,
                                            age: age,
                                            activityLevel: input.activityLevel,
                                            goal: input.goal
                                        )
                                    } else {
                                        calculated = ProteinIntakeCalculator.calculateGoal(weight: w, sex: input.sex)
                                    }
                                    proteinGoal = calculated
                                    draftGoal = calculated
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.vertical)
                            }

                            Spacer().frame(height: 80)
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.medium)
                .padding(.top)
            }
        }
        .baseScreenStyle()
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
}

#Preview {
    ProteinGoalSettingView()
        .environmentObject(NavigationModel())
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self, ProteinLog.self])
}
