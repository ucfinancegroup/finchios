//
//  AppTabView.swift
//  finchios
//
//  Created by Brett Fazio on 12/16/20.
//

import SwiftUI

struct AppTabView: View {

    @Binding var navBarHidden: Bool

    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            // Overview
            OverviewView(navBarHidden: $navBarHidden)
                .tabItem {
                    if selection == 0 {
                        Image(uiImage: UIImage(named: "HomeFilled")!.withTintColor(.teal))
                    }else {
                        Image(uiImage: UIImage(named: "HomeClear")!.withTintColor(.systemGray))
                    }
                    
                        
                    Text("Overview")
                }
                .tag(0)
            // Projection
            ProjectionView(navBarHidden: $navBarHidden)
                .tabItem {
                    if selection == 1 {
                        Image(uiImage: UIImage(named: "ProjectionFilled")!.withTintColor(.teal))
                    }else {
                        Image(uiImage: UIImage(named: "ProjectionClear")!.withTintColor(.systemGray))
                    }
                    
                        
                    Text("Projection")
                }
                .tag(1)
            
            // Statistics
//            StatisticsView(navBarHidden: $navBarHidden)
//                .tabItem {
//                    if selection == 2 {
//                        Image(uiImage: UIImage(named: "TrophyFilled")!.withTintColor(.teal))
//                    }else {
//                        Image(uiImage: UIImage(named: "TrophyClear")!.withTintColor(.systemGray))
//                    }
//
//                    Text("Stats")
//                }
//                .tag(2)
            
            // Settings
            SettingsView(navBarHidden: $navBarHidden)
                .tabItem {
                    if selection == 2 {
                        Image(uiImage: UIImage(named: "GearFilled")!.withTintColor(.teal))
                    }else {
                        Image(uiImage: UIImage(named: "GearClear")!.withTintColor(.systemGray))
                    }
                    
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(.teal)
        .onAppear {
            self.navBarHidden = true
        }
        //TODO(): Not properly hiding on transition from signUp
        .navigationBarTitle("")
        .navigationBarHidden(self.navBarHidden)
        .navigationBarBackButtonHidden(self.navBarHidden)
    }
}

struct AppTabViewPreviewer: View {
    @State private var value = false

    var body: some View {
        AppTabView(navBarHidden: $value)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabViewPreviewer()
    }
}
