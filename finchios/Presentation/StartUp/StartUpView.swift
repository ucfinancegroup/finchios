//
//  StartUpView.swift
//  finchios
//
//  Created by Brett Fazio on 8/23/20.
//  Copyright © 2020 Brett Fazio. All rights reserved.
//

import SwiftUI

struct StartUpView: View {

    @State var navBarHidden: Bool = false

    @StateObject private var model = StartUpViewModel()

    //TODO(): Pass is nav bar hidden down the stack
    var body: some View {
        NavigationView {
            VStack {
                if model.segueLanding {
                    IntroductionView(navBarHidden: $navBarHidden)
                }
                if model.segueApp {
                    AppTabView(navBarHidden: $navBarHidden)
                }
            }
        }
        .onAppear {
            self.model.viewAppeared()
        }
        .navigationBarTitle(self.navBarHidden ? "" : "Start Up")
        .navigationBarHidden(self.navBarHidden)
        .navigationBarBackButtonHidden(self.navBarHidden)
    }
}

struct StartUpView_Previews: PreviewProvider {
    static var previews: some View {
        StartUpView()
    }
}
