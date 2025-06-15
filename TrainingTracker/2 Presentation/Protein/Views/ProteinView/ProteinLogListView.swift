//
//  ProteinLogListView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//

import SwiftUI

struct ProteinLogListView: View {
    let logs: [ProteinLog]
    let onDelete: (ProteinLog) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.medium) {
            Text("本日の記録")
                .font(.headline)
                .foregroundColor(AppColor.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                if logs.isEmpty {
                    Text("No record")
                        .foregroundColor(AppColor.lightGray)
                        
                } else {
                    VStack {
                        ForEach(Array(logs.enumerated()), id: \.element.id) { index, log in
                            ProteinLogCard(
                                time: log.dateTime.timeOnly,
                                amount: Int(log.amount),
                                index: index + 1,
                                onDelete: {
                                    onDelete(log)
                                }
                            )
                        }
                    }
                }
            }
        }
        .frame(height: UIScreen.screenHeight * 3/10)
    }
}

struct ProteinLogCard: View {
    let time: String
    let amount: Int
    let index: Int
    let onDelete: () -> Void
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    var body: some View {
        HStack {
            IconCircleView(systemName: "mug.fill", size: 48)
            
            VStack(alignment: .leading, spacing: AppSpacing.medium) {
                Text("\(index)回目")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(ThemeColor.from(mainColorName).color)
                
                HStack(spacing: AppSpacing.medium) {
                    HStack{
                        Image(systemName: "calendar.badge.clock")
                        Text(time)
                    }
                    HStack{
                        Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        Text("\(amount)g")
                    }
                }
                .foregroundColor(AppColor.white)
                .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding(.trailing)
        }
        .cardStyle()
        .padding(.bottom, AppSpacing.small)
    }
}
