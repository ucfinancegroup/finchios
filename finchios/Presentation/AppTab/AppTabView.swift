//
//  AppTabView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct AppTabView: View {

    @Binding var navBarHidden: Bool

    var body: some View {
        TabView {
            // Projection
            ProjectionView(navBarHidden: $navBarHidden)
                .tabItem { Text("Projection") }
            
            // Statistics
            
            // Settings
            SettingsView(navBarHidden: $navBarHidden)
                .tabItem { Text("Settings") }
        }
        .onAppear {
            self.navBarHidden = true
        }
        //TODO(): Not properly hiding on transition from signUp
        .navigationBarTitle("")
        .navigationBarHidden(self.navBarHidden)
        .navigationBarBackButtonHidden(self.navBarHidden)
    }
}

struct AppTabViewPreviewer: View {
    @State private var value = false

    var body: some View {
        AppTabView(navBarHidden: $value)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabViewPreviewer()
    }
}
