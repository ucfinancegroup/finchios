//
//  NewGoalViewModel.swift
//  finchios
//
//  Created by Brett Fazio on 1/16/21.
//

import Foundation

class NewGoalViewModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var alertType: SuccessFail = .success
    @Published var errorDetail: String = ""
    
}
