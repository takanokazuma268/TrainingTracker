//
//  ProteinLog.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/02.
//
import SwiftData
import Foundation

@Model
class ProteinLog {
    @Attribute(.unique) var id: UUID
    var dateTime: Date
    var amount: Double

    init(id: UUID = UUID(), dateTime: Date, amount: Double) {
        self.id = id
        self.dateTime = dateTime
        self.amount = amount
    }
}
