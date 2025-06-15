//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//
import SwiftUI

struct SearchFieldView: View {
    @Binding var text: String

    var body: some View {
        TextField("種目名で検索", text: $text)
            .padding(AppSpacing.medium)
            .background(AppColor.lightGray)
            .cornerRadius(AppCornerRadius.medium)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .submitLabel(.search)
            .textSelection(.enabled)
            .onSubmit {}
    }
}
