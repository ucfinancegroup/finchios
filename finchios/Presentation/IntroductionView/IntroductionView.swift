//
//  IntroductionView.swift
//  finchios
//
//  Created by Brett Fazio on 8/29/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI

struct IntroductionView: View {

    @Binding var navBarHidden: Bool

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {

            Color(colorScheme == .light ? .white : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {

                Spacer()
                    .frame(height: 50)

                Text("Welcome to Finch")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .accessibility(identifier: "introductionLabel")

                Spacer()

                NavigationLink(destination: SignUpNameView(navBarHidden: $navBarHidden)) {

                    Text("Sign Up")
                        .frame(width: 100)
                        .font(.headline)
                        .padding()
                        .cornerRadius(40)
                }
                .accessibility(identifier: "introductionSignUpLink")

                Spacer()
                    .frame(height: 25)

                // TODO(): Might need color adjustment on dark mode
                NavigationLink(destination: LogInView(navBarHidden: $navBarHidden)) {
                    Text("Already have an account? Log in.")
                        .foregroundColor(Color.gray)
                }

            }
            .navigationBarTitle("")
            .navigationBarHidden(self.navBarHidden)
            .navigationBarBackButtonHidden(self.navBarHidden)
            .padding()
        }
    }
}

struct IntroductionViewPreviewer: View {
    @State private var value = false

    var body: some View {
        IntroductionView(navBarHidden: $value)
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionViewPreviewer()
    }
}
