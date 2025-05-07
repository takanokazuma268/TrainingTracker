//
//  WorkoutLogView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/07.
//

import SwiftUI

struct WorkoutLogView: View {
    @State private var workoutDate: Date = Date()
    @State private var sets: [WorkoutInputRow] = [
        WorkoutInputRow(set: 1),
        WorkoutInputRow(set: 2),
        WorkoutInputRow(set: 3)
    ]

    var body: some View {
        VStack(spacing: 24) {
            Text("WORKOUT LOG")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
            
            Text("BENCH PRESS")
                .font(.title2)
                .foregroundColor(.white)
            
            HStack {

                Text("Date")
                    .foregroundColor(.white)
                DatePicker("", selection: $workoutDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            VStack(spacing: 12) {
                HStack {
                    Text("SET")
                    Spacer()
                    Text("WEIGHT")
                    Spacer()
                    Text("REPS")
                }
                .foregroundColor(.yellow)
                .font(.headline)

                Divider().background(Color.yellow)

                ForEach($sets) { $row in
                    HStack {
                        WorkoutInputRowView(row: $row)
                        Button(action: {
                            sets.removeAll { $0.id == row.id }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }

                Button(action: {
                    let nextSet = sets.count + 1
                    sets.append(WorkoutInputRow(set: nextSet))
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Set")
                    }
                    .foregroundColor(.yellow)
                }
            }
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)

            Spacer()

            Button(action: {
                print("Saved workout on \(workoutDate)")
                for row in sets {
                    print("Set \(row.set): \(row.weight)kg x \(row.reps) reps")
                }
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
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
    }
}


struct WorkoutInputRow: Identifiable {
    let id = UUID()
    let set: Int
    var weight: String = ""
    var reps: String = ""
}

struct WorkoutInputRowView: View {
    @Binding var row: WorkoutInputRow

    var body: some View {
        HStack {
            Text("\(row.set)")
                .frame(width: 40, alignment: .leading)
            Spacer()
            TextField("kg", text: $row.weight)
                .keyboardType(.decimalPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80)
            Spacer()
            TextField("reps", text: $row.reps)
                .keyboardType(.numberPad)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(width: 80)
        }
        .foregroundColor(.white)
    }
}

#Preview {
    WorkoutLogView()
}


#Preview {
    WorkoutLogView()
}
