//
//  SwiftUIView.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/05/22.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText: String

    var body: some View {
        TextField("種目名で検索", text: $searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .submitLabel(.search)
            .textSelection(.enabled)
            .onSubmit {}
    }
}
