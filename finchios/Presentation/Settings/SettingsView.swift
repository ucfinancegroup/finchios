//
//  SettingsView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct SettingsView: View {

    @Binding var navBarHidden: Bool

    @StateObject var model: SettingsViewModel = SettingsViewModel()

    var body: some View {
        ZStack {

            NavigationLink(destination: IntroductionView(navBarHidden: $navBarHidden), isActive: $model.resetApp) {
                EmptyView()
            }

            // Content
            Form {
                Section(header: Text("Account")) {
                    Text("Email: \(CredentialsObject.shared.email)")
                    
                    //TODO() Change to real views
                    NavigationLink("Change Password", destination: ChangePasswordView())
                    NavigationLink("Change Personal Info", destination: AboutView())
                    NavigationLink("Edit Income", destination: AboutView())
                }
                Section(header: Text("")) {
                    NavigationLink("About", destination: AboutView())

                    //TODO(): Entry point for editing Plaid accounts (Link entry)
                }
                Section(header: Text("")) {
                    Button(action: {
                        // Log out
                        navBarHidden = true
                        self.model.logOut()
                    }) {
                        Text("Log Out")
                    }
                }
            }
            .navigationBarTitle(navBarHidden ? "" : "Settings")
            .navigationBarHidden(navBarHidden)
            .navigationBarBackButtonHidden(navBarHidden)
        }
    }
}

struct SettingsViewPreview: View {
    
    @State var bind = true
    
    var body: some View {
        SettingsView(navBarHidden: $bind)
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewPreview()
    }
}

