//
//  ProteinViewModel.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/02.
//
import Foundation
import SwiftData

final class ProteinViewModel: ObservableObject {
    @Published var sum : Double = 0
    @Published var record : [ProteinLog] = []
    private var proteinLogRepo: ProteinLogRepo?
    
    func setupRepository(with context: ModelContext) {
        self.proteinLogRepo = ProteinLogRepo(context: context)
    }
    
    func fetchByDate(for date: Date) {
        do {
            self.record = try proteinLogRepo?.fetchByDate(date) ?? []
        } catch {
            print("Error fetching logs: \(error)")
            self.record = []
        }
    }
    
    func totalAmountByDate(for date: Date) {
        do {
            self.sum = try proteinLogRepo?.totalAmountByDate(date) ?? 0
        } catch {
            print("Error updating sum: \(error)")
            self.sum = 0
        }
    }
    
    func insert(dateTime: Date, amount: Double) {
        do {
            try proteinLogRepo?.insert(ProteinLog(dateTime: dateTime, amount: amount))
        } catch {
            print("Error adding log: \(error)")
        }
        totalAmountByDate(for: Date())
        fetchByDate(for: Date())
    }

    
    func delete(log: ProteinLog) {
        do {
            try proteinLogRepo?.delete(log)
        } catch {
            print("Error deleting log: \(error)")
        }
        totalAmountByDate(for: Date())
        fetchByDate(for: Date())
    }

}


