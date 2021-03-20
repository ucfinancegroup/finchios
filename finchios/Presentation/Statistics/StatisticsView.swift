//
//  StatisticsView.swift
//  finchios
//
//  Created by Brett Fazio on 12/17/20.
//

import SwiftUI

struct StatisticsView: View {
    @Binding var navBarHidden: Bool

    var body: some View {
        ScrollView {
            LeaderboardView()
        }
        .navigationBarTitle(navBarHidden ? "" : "Statistics")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}
