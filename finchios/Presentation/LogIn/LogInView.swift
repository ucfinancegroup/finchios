//
//  LogInView.swift
//  finchios
//
//  Created by Brett Fazio on 8/21/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI
import Combine

struct LogInView: View {

    @Binding var navBarHidden: Bool

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @ObservedObject private var model = LogInViewModel()

    var body: some View {
        ZStack {

            NavigationLink(destination: AppTabView(navBarHidden: $navBarHidden), isActive: $model.logInSuccess) {
                EmptyView()
            }

            Color(colorScheme == .light ? .green : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                //TODO(): ubumpWhite isn't a pdf
                //Image(colorScheme == .light ? "uBumpBlack" : "uBumpWhite")

                Spacer()
                    .frame(height: 50)

                Text("Login to your Finch account!")
                    .font(.headline)

                Spacer()
                    .frame(height: 50)

                // TODO(): Move this group up on keyboard up
                Group {

                    Text("Email:")

                    TextField("Email", text: $model.email, onEditingChanged: { (_) in
                    })
                        .textContentType(.emailAddress)
                        .multilineTextAlignment(.center)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    Text("Password:")
                    SecureField("Password", text: $model.password)
                        .textContentType(.password)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                Button(action: {
                    self.model.logInTapped()
                }) {
                    Text("Log in!")
                        .frame(width: 100)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(40)
                }
            }
            .padding(20)
            //TODO(): Make nav bar disappear on login
            .onDisappear {
                self.navBarHidden = true
            }
            .navigationBarHidden(self.navBarHidden)
            .navigationBarBackButtonHidden(self.navBarHidden)
            .alert(isPresented: $model.logInError) { () -> Alert in
                return Alert(title: Text("Failed to Log In"), message: Text("Please ensure that the username and password entered are correct and try again."), dismissButton: .default(Text("Okay")))
            }
        }
    }
}

struct LogInViewPreviewer: View {
    @State private var value = false

    var body: some View {
        LogInView(navBarHidden: $value)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInViewPreviewer()
    }
}
