//
//  SignUpFinancialsView.swift
//  finchios
//
//  Created by Brett Fazio on 2/19/21.
//

import SwiftUI

struct SignUpFinancialsView: View {

    @Binding var navBarHidden: Bool

    @EnvironmentObject private var model: SignUpModel

    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .teal : .black)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Please provide estimates for your income and net worth.")
                    .font(.title)
                    .foregroundColor(.white)

                Spacer()

                NumberField(text: $model.netWorth, alignment: .center, keyType: .decimalPad, placeholder: "Net Worth")
                    .padding()
                
                NumberField(text: $model.income, alignment: .center, keyType: .decimalPad, placeholder: "Income")
                    .padding()
                
                Spacer()

                Button(action: {
                    self.model.validateFinancials()
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

                NavigationLink(destination: SignUpEmailView(navBarHidden: $navBarHidden).environmentObject(model), isActive: $model.finValid) {
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
        .alert(isPresented: $model.finError) { () -> Alert in
            return Alert(title: Text("One of your inputted numbers is invalid. Please ensure they are both non-empty and only contain digits"), message: nil, dismissButton: .default(Text("Okay")))
        }
    }
}

struct SignUpFinancialsViewPreviewer: View {
    @State private var value = false

    var body: some View {
        SignUpFinancialsView(navBarHidden: $value)
    }
}

struct SignUpFinancialsView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFinancialsViewPreviewer()
    }
}
