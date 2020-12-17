//
//  SignUpNameView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct SignUpNameView: View {

    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .green : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("What is your full name (First space Last)?")
                    .font(.title)

                Spacer()

                TextField("Name", text: $model.name, onEditingChanged: { (_) in

                })
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)

                Spacer()

                Button(action: {
                    self.model.validateName()
                }) {
                    Text("Continue")
                        .frame(width: 100)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(40)
                }

                NavigationLink(destination: SignUpEmailView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.nameValid) {
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
            return Alert(title: Text("\(self.model.name) is not a valid name."), message: nil, dismissButton: .default(Text("Okay")))
        }
    }
}

struct SignUpNameViewPreviewer: View {
    @State private var value = false

    var body: some View {
        SignUpEmailView(navBarHidden: $value)
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmailViewPreviewer()
    }
}
