import SwiftUI
import Charts

struct ProteinChartView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Environment(\.modelContext) private var modelContext
    @StateObject private var ProteinChartVM = ProteinChartViewModel()
    @State private var selectedDate: Date = Date()

    var body: some View {
        BaseNavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                WeekNavigationView(ProteinChartVM: ProteinChartVM)

                AverageLabelView(average: ProteinChartVM.weeklyAverage)

                WeeklyProteinChartView(weeklyData: ProteinChartVM.weeklyTotals)
                
                DayPickerView(
                    selectedDate: $selectedDate,
                    availableDates: ProteinChartVM.weeklyTotals.map { $0.0 },
                    onDateChange: handleDateChange
                )

                ProteinLogListView(logs: ProteinChartVM.record, onDelete: { log in
                    ProteinChartVM.delete(log: log)
                })
                Spacer()
            }
            .onAppear {
                ProteinChartVM.setupRepository(with: modelContext)
                ProteinChartVM.loadWeeklyTotals()
            }
        }
        .navigationDestination(for: AppPath.self) { path in
            path.destinationView()
        }
    }
    
    private func handleDateChange(_ date: Date) {
        do {
            try ProteinChartVM.fetchRecordsByDate(date)
        } catch {
            print("Error fetching records: \(error)")
        }
    }
}

#Preview {
    ProteinChartView()
        .environmentObject(NavigationModel())
        .modelContainer(for: [WorkoutLog.self, WorkoutSet.self, ProteinLog.self])
}
