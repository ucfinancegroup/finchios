//
//  OverviewView.swift
//  finchios
//
//  Created by Brett Fazio on 2/22/21.
//

import SwiftUI

struct OverviewView: View {
    
    @Binding var navBarHidden: Bool
    
    @StateObject var model = OverviewModel()
    
    var body: some View {
        VStack {
            
            GraphView(type: .overview)
            
        }
        //.background(Color.lightGray)
        .onAppear() {
            self.navBarHidden = true
            self.model.onAppear()
        }
        .navigationBarTitle(navBarHidden ? "" : "Overview")
        .navigationBarHidden(navBarHidden)
        .navigationBarBackButtonHidden(navBarHidden)
    }
}

struct OverviewViewPreview: View {
    
    @State var hidden: Bool = true
    
    var body: some View {
        OverviewView(navBarHidden: $hidden)
    }
    
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewViewPreview()
    }
}
