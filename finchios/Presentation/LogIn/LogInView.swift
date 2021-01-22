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
    
    @State var transition: Bool = false
    
    var body: some View {
        ZStack {
            
            NavigationLink(destination: AppTabView(navBarHidden: $navBarHidden), isActive: $transition) {
                EmptyView()
            }
            
            Color(colorScheme == .light ? .teal : .black)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                //TODO(): ubumpWhite isn't a pdf
                //Image(colorScheme == .light ? "uBumpBlack" : "uBumpWhite")
                
                Text("Login to your Finch account!")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 50)
                
                
                // TODO(): Move this group up on keyboard up
                Group {
                    
                    
                    TextField("Email", text: $model.email, onEditingChanged: { (_) in
                    })
                    .textContentType(.emailAddress)
                    .multilineTextAlignment(.center)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    SecureField("Password", text: $model.password)
                        .textContentType(.password)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {
                    self.model.logInTapped()
                }) {
                    Text("Log in!")
                        .frame(width: 100)
                        .font(.headline)
                        .foregroundColor(Color.teal)
                        .padding()
                        .background(Color.white)
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
            .alert(isPresented: $model.showAlert) { () -> Alert in
                if model.logInError {
                    return Alert(title: Text("Failed to Log In"), message: Text("Please ensure that the username and password entered are correct and try again. Error: \(self.model.errorStr)"), dismissButton: .default(Text("Okay")))
                }
                else { // success
                    return Alert(title: Text("Success!"),
                                 message: Text("Welcome back to Finch."),
                                 dismissButton: .default(Text("Okay")) {
                                    self.transition = true
                                 })
                }
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
