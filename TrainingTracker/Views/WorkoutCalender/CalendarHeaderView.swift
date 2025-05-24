//
//  CalendarHeaderView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/24.
//

import SwiftUI

struct CalendarHeader: View {
    @ObservedObject var calendarVM: CalendarViewModel

    var body: some View {
        HStack {
            Button(action: {
                calendarVM.changeMonth(by: -1)
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.yellow)
            }

            Spacer()

            Text(calendarVM.monthYearString(from: calendarVM.currentMonth))
                .foregroundColor(.yellow)
                .font(.title2.bold())

            Spacer()

            Button(action: {
                calendarVM.changeMonth(by: 1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal)
    }
}
