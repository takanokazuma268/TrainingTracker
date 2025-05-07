//
//  HomeView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/06.
//
import SwiftUI
// HomeView.swift
struct HomeView: View {
    let todaysExercises: [Exercise] = [
        Exercise(title: "ベンチプレス", reps: "8回", weight: "80kg", sets: "3セット"),
        Exercise(title: "ダンベルフライ", reps: "10回", weight: "20kg", sets: "3セット"),
        Exercise(title: "プッシュアップ", reps: "15回", weight: nil, sets: "3セット")
    ]
    @State private var isWorkoutSelectionView: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if isWorkoutSelectionView {
                WorkoutSelectionView()
            } else {
            VStack(spacing: 20) {
                Image("LOGO")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity, alignment: .center)

                Text("本日のエクササイズ")
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(todaysExercises) { exercise in
                            WorkoutCardView(exercise: exercise)
                        }
                    }
                }
                

                    Button(action: {
                        isWorkoutSelectionView.toggle()
                    }) {
                        HStack {
                            Image(systemName: "dumbbell.fill")
                            Text("トレーニング開始")
                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(12)
                    }
                }.padding()
            }
            
        }
        
    }
    
    
}

// Exercise.swift
struct Exercise: Identifiable {
    let id = UUID()
    let title: String
    let reps: String
    let weight: String?
    let sets: String
}

// WorkoutCardView.swift
struct WorkoutCardView: View {
    var exercise: Exercise

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                HStack {
                    Text(exercise.reps)
                    if let weight = exercise.weight {
                        Text(weight)
                    }
                }
                .font(.subheadline)
                .foregroundColor(.gray)
            }

            Spacer()

            VStack {
                Text(exercise.sets)
                    .foregroundColor(.white)
                    .font(.headline)
                Text("Sets")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(.darkGray))
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
}
