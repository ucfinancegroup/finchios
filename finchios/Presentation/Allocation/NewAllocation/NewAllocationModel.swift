//
//  NewAllocationModel.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import Foundation
import OpenAPIClient

class NewAllocationModel: ObservableObject, Identifiable, AllocationSliderProtocol {
    
    // Fields
    @Published var title: String = ""
    @Published var date: Date = Date()
    
    @Published var classes: [(Iden<AssetClassAndApy>, Iden<Double>)] = []
    
    @Published var classTypes: [Iden<AssetClassAndApy>] = []
    
    init() {
        
        AssetService.get { (success, error, result) in
            DispatchQueue.main.async {
                if let result = result {
                    self.classTypes = result.map { Iden<AssetClassAndApy>(obj: $0) }
                }
            }
        }
        
    }
    
    // Alerts
    @Published var showAlert: Bool = false
    
    @Published var showError: Bool = false
    var errorString: String = ""
    
    @Published var showSuccess: Bool = false
    
    func getSum() -> Int {
        return 0
    }
    
    func getAllocationObject() -> Allocation? {
        return nil
    }
    
    func create() {
        
    }
    
    func newClass() {
        if classTypes.count == 0 {
            return
        }
        
        classes.append((classTypes[0], Iden<Double>(obj: 0)))
    }
    
    func delete(c: UUID, amount: UUID) {
        classes.removeAll(where: { $0.0.id == c })
    }
    
    
}
