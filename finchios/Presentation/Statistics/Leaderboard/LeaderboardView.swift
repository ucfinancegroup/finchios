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
            HStack {
                Text("Leaderboards")
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding()
            
            if model.boards.count == 0 {
                Text("Error: No similar users to compare against.")
            } else {
                ForEach(model.boards, id: \.id) { ranking in
                    HStack {
                        LeaderboardItemView(board: .constant(ranking.obj))
                        Spacer()
                        NavigationLink(
                            destination: LeaderboardItemDetailsView(board: .constant(ranking.obj)),
                            label: {
                                Image("RightArrow")
                            })
                    }
                    .padding()
                    .bubble()
                }
            }
        }
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
