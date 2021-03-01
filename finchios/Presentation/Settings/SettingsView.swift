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
                    NavigationLink("Change Password", destination: ChangePasswordView())
                    NavigationLink("Change Personal Info", destination: ChangeName())
                    NavigationLink("Edit Income", destination: ChangeFinancials())
                }
                Section(header: Text("Information")) {
                    NavigationLink("About", destination: AboutView())

                    //TODO(): Entry point for editing Plaid accounts (Link entry)
                }
                Section(header: Text("Application")) {
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

