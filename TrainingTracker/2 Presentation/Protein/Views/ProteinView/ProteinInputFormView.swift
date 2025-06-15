//
//  ProteinInputFormView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/06.
//

import SwiftUI

struct ProteinInputForm: View {
    @ObservedObject var ProteinVM: ProteinViewModel
    @State private var dateTime: Date = Date()
    @State private var amount: String = ""
    @State private var showAlert: Bool = false
    @AppStorage("mainColorName") private var mainColorName: String = ThemeColor.brightGold.rawValue
    
    var body: some View {
        VStack{
            HStack {
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(ThemeColor.from(mainColorName).color)
                        .font(.title3)
                    DatePicker("", selection: $dateTime, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .colorScheme(.dark)
                }
                
                HStack {
                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .foregroundColor(ThemeColor.from(mainColorName).color)
                        .font(.title3)
                    TextField("g", text: $amount)
                        .frame(height: 38)
                        .padding(.horizontal, 12)
                        .background(
                            AppColor.darkGray
                                .cornerRadius(AppCornerRadius.medium)
                        )
                        .colorScheme(.dark)
                        .keyboardType(.numberPad)
                }
            }

            MainButtonView(
                action: {
                    if amount.isEmpty {
                        showAlert = true
                    } else if let doubleAmount = Double(amount) {
                        ProteinVM.insert(dateTime: dateTime, amount: doubleAmount)
                    }
                },
                title: "保存",
                iconName: "tray.and.arrow.down.fill"
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("入力エラー"),
                    message: Text("摂取量を入力してください。"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding(.top)
    }
}
