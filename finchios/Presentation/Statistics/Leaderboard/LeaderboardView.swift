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
            Text("Leaderboards").font(.title)
            
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
        .padding()
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
