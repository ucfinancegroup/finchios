//
//  ProjectionView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct ProjectionView: View {

    @Binding var navBarHidden: Bool

    var body: some View {
        ZStack {

        }
        .navigationBarTitle(navBarHidden ? "" : "Settings")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}
