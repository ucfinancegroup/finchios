//
//  SignUpBirthdayView.swift
//  finchios
//
//  Created by Brett Fazio on 2/7/21.
//

import SwiftUI

struct SignUpBirthdayView: View {

    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .teal : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("What is your date of birth?")
                    .font(.title)
                    .foregroundColor(.white)

                Spacer()

                DatePicker("Date of Birth", selection: $model.dob)

                Spacer()

                Button(action: {
                    self.model.validateDOB()
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

struct SignUpBirthdayViewPreviewer: View {
    @State private var value = false

    var body: some View {
        SignUpBirthdayView(navBarHidden: $value)
    }
}

struct SignUpBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdayViewPreviewer()
    }
}
