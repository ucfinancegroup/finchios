//
//  SignUpNameView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct SignUpNameView: View {

    @Binding var navBarHidden: Bool

    @StateObject private var model: SignUpModel = SignUpModel()

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .teal : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("What is your full name?")
                    .font(.title)
                    .foregroundColor(.white)

                Spacer()

                TextField("First Name", text: $model.firstName, onEditingChanged: { (_) in
                })
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("Last Name", text: $model.lastName, onEditingChanged: { (_) in
                })
                    .foregroundColor(.white)
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
                        .foregroundColor(Color.teal)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(40)
                }
                
                Spacer()

                NavigationLink(destination: SignUpBirthdayView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.nameValid) {
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
        .alert(isPresented: $model.nameError) { () -> Alert in
            //TODO(): provide better errors
            return Alert(title: Text("\(self.model.firstName) \(self.model.lastName) is not a valid name or a field is empty."), message: nil, dismissButton: .default(Text("Okay")))
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
