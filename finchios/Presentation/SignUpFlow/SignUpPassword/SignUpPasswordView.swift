//
//  SignUpPasswordView.swift
//  finchios
//
//  Created by Brett Fazio on 8/29/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI

struct SignUpPasswordView: View {
    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .green : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Create your password")
                    .font(.title)

                Spacer()

                //TODO(): Automatically move up when keyboard appears?
                SecureField("Password", text: $model.password) {

                }
                    .multilineTextAlignment(.center)

                Spacer()
                    .frame(height: 25)

                SecureField("Confirm Password", text: $model.confirmPassword) {

                }
                    .multilineTextAlignment(.center)

                Spacer()

                Button(action: {
                    self.model.createAccount()
                }) {
                    Text("Create Account")
                        .frame(width: 200)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(40)
                }

                NavigationLink(destination: AppTabView(navBarHidden: $navBarHidden), isActive: $model.accountCreated) {
                    EmptyView()
                }
            }
        }
        .onAppear {
            self.model.onAppear()
        }
        .alert(isPresented: $model.creationFailed) { () -> Alert in
            //TODO(): Better errors if signUp failed.
            switch model.creationErrorType {
            case .activate:
                return Alert(title: Text("Account created but tag failed to register."), message: Text("Your uBump account was successfully created but your uBump failed to register (our fault not yours). Please go into the \"Scan\" page and select \"activate a new uBump\" to associate your uBump with your account!"), dismissButton: .destructive(Text("Okay")) {
                    self.model.creationFailed = false
                    self.model.accountCreated = true
                    })
            case .signUp:
                return Alert(title: Text("Failed to create account"), message: Text("Account creation failed. Please go back and make sure all the information you entered is valid or ensure you have a proper internet connection."), dismissButton: .destructive(Text("Okay")) {
                    self.model.creationFailed = false
                    })
            }

        }
    }
}

struct SignUpPasswordViewPreviewer: View {
    @State private var value = false

    @ObservedObject var model = SignUpModel()

    var body: some View {
        SignUpPasswordView(navBarHidden: $value)
            .environmentObject(model)
    }
}

struct SignUpPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPasswordViewPreviewer()
    }
}
