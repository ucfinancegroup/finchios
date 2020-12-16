//
//  SignUpUsernameView.swift
//  ubump-ios
//
//  Created by Brett Fazio on 8/29/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI

struct SignUpUsernameView: View {
    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    //TODO(): Maybe give each slide in the sequence its own mini model?
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .uBumpLightBlue : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Choose your username")
                    .font(.title)

                Spacer()

                //TODO(): Need to restrict spaces
                TextField("Username", text: $model.username, onEditingChanged: { (_) in

                })
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)

                Spacer()

                Button(action: {
                    self.model.validateUsername()
                }) {
                    Text("Continue")
                        .frame(width: 100)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color(.uBumpBlue))
                        .cornerRadius(40)
                }

                NavigationLink(destination: SignUpPasswordView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.usernameValid) {
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
        .alert(isPresented: $model.usernameError) { () -> Alert in
            //TODO(): provide better errors
            return Alert(title: Text("\(self.model.username) is not available. Please choose another."), message: nil, dismissButton: .default(Text("Okay")))
        }
    }
}

struct SignUpUsernameViewPreviewer: View {
    @State private var value = false

    @ObservedObject var model = SignUpModel()

    var body: some View {
        SignUpUsernameView(navBarHidden: $value)
            .environmentObject(model)
    }
}

struct SignUpUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpUsernameViewPreviewer()
    }
}
