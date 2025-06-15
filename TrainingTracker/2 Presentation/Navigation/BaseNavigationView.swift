//
//  Untitled.swift
//  TrainingTracker
//
//  Created by 高野和馬 on 2025/06/04.
//
import SwiftUI

struct BaseNavigationView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $navigationModel.path) {
            content()
                .baseScreenStyle()
                .navigationDestination(for: AppPath.self) { path in
                    path.destinationView()
                }
        }
    }
}
