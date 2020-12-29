//
//  SignUpEmailView.swift
//  finchios
//
//  Created by Brett Fazio on 8/29/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI

struct SignUpEmailView: View {

    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .teal : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("What is your email?")
                    .font(.title)
                    .foregroundColor(.white)

                Spacer()

                TextField("Email", text: $model.email, onEditingChanged: { (_) in

                })
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                Spacer()

                Button(action: {
                    self.model.validateEmail()
                }) {
                    Text("Continue")
                        .frame(width: 100)
                        .font(.headline)
                        .foregroundColor(Color.teal)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(40)
                }
                
                Spacer()

                NavigationLink(destination: SignUpPasswordView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.emailValid) {
                    EmptyView()
                }
            }
        }
        .onAppear {
            self.model.onAppear()
        }
        .onDisappear {
            self.model.onDisappaer()
        }
        .alert(isPresented: $model.emailError) { () -> Alert in
            //TODO(): provide better errors
            return Alert(title: Text("\(self.model.email) is either not a valid email or is already associated with an account. Please enter a different email."), message: nil, dismissButton: .default(Text("Okay")))
        }
    }
}

struct SignUpEmailViewPreviewer: View {
    @State private var value = false

    var body: some View {
        SignUpEmailView(navBarHidden: $value)
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmailViewPreviewer()
    }
}
