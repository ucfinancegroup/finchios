//
//  LeaderboardView.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import SwiftUI

struct LeaderboardView: View {
    
    @StateObject var model = LeaderboardViewModel()
    
    var body: some View {
        VStack {
            Text("Leaderboards")
            
            ForEach(model.boards.indices, id: \.self) { index in
                Divider()
                HStack {
                    LeaderboardItemView(board: model.boards[index])
                    NavigationLink(
                        destination: GoalView(),
                        label: {
                            Image("RightArrow")
                        })
                }
            }
        }
        .padding()
        .bubble()
        .onAppear() {
            model.onAppear()
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
