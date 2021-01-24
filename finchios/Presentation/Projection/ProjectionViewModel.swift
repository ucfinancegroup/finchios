//
//  ProjectionViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 12/17/20.
//

import Foundation
import OpenAPIClient

public class ProjectionViewModel: ObservableObject, Identifiable {

    @Published public var insights: [Iden<Insight>] = []
    
    private var insightsGen: Bool = false
    
    public func onAppear() {
        self.fetchInsights()
    }
    
    private func fetchInsights() {
        if insightsGen {
            return
        }
        insightsGen = true
        
        // Fetch Insights
    }
    
}
