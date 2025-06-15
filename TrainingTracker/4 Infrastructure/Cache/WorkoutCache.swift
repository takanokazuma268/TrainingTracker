//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/27.
//
import Foundation


class WorkoutCache: BaseCache<Workout> {
    static let shared = WorkoutCache()
    private override init() {}

    override func load(from url: URL) throws {
        struct RawWorkout: Decodable {
            let code: String
            let jaName: String
            let enName: String
            let imageName: String?
            let mainMuscles: [String]
            let subMuscles: [String]
            let equipment: [String]?
            let displayPriority: Int
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let rawWorkouts = try decoder.decode([RawWorkout].self, from: data)

        self.items = rawWorkouts.map { raw in
            let mainMuscles = raw.mainMuscles.compactMap { code in
                MainMuscleCache.shared.items.first { $0.code == code }
            }
            let subMuscles = raw.subMuscles.compactMap { code in
                SubMuscleCache.shared.items.first { $0.code == code }
            }

            return Workout(
                code: raw.code,
                jaName: raw.jaName,
                enName: raw.enName,
                imageName: raw.imageName,
                mainMuscles: mainMuscles,
                subMuscles: subMuscles,
                equipment: raw.equipment,
                displayPriority: raw.displayPriority
            )
        }
    }

    func getWorkout(byCode code: String) -> Workout? {
        return items.first { $0.code == code }
    }

    func getByMainMuscleCode(_ mainMuscleCode: String) -> [Workout] {
        return items.filter { workout in
            workout.mainMuscles.contains { $0.code == mainMuscleCode }
        }
    }
}
