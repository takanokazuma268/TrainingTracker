//
//  Cache.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/29.
//

import Foundation

class BaseCache<T: Decodable> {
    var items: [T] = []

    func load(from url: URL) throws {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        self.items = try decoder.decode([T].self, from: data)
    }

    func reset() {
        items = []
    }
}
