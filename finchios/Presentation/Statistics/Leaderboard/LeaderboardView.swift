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
            ForEach(model.boards.indices) { index in
                LeaderboardItemView(board: $model.boards[index])
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
