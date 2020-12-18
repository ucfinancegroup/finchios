//
//  SettingsView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct SettingsView: View {

    @Binding var navBarHidden: Bool

    @ObservedObject var model: SettingsViewModel = SettingsViewModel()

    var body: some View {
        ZStack {

            NavigationLink(destination: IntroductionView(navBarHidden: $navBarHidden), isActive: $model.resetApp) {
                EmptyView()
            }

            // Content
            Form {
                Button(action: {
                    // Log out
                    navBarHidden = true
                    self.model.logOut()
                }) {
                    Text("Log Out")
                }
                //TODO(): Entry point for editing Plaid accounts (Link entry)
            }
            .onAppear {
                self.navBarHidden = false
            }
            .navigationBarTitle(navBarHidden ? "" : "Settings")
            .navigationBarHidden(navBarHidden)
            .navigationBarBackButtonHidden(navBarHidden)
        }
    }
}
