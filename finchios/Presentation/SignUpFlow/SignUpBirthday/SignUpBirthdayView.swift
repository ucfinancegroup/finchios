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

                DatePicker("Date of Birth", selection: $model.dob, displayedComponents: [.date])
                    .padding()
                    .accessibility(identifier: "dob_picker")
                
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

                NavigationLink(destination: SignUpFinancialsView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.dobValid) {
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
        .alert(isPresented: $model.dobError) { () -> Alert in
            return Alert(title: Text("You need to be 18 to use Finch. The given date of birth, \(model.formatedDOB()), does not indicate you are eligible for an account."), message: nil, dismissButton: .default(Text("Okay")))
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
