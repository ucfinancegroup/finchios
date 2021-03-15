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
        
        var sum = 0
        
        for pair in classes {
            sum += Int(pair.1.obj)
        }
        
        return sum
    }
    
    func getAllocationObject() -> Allocation? {
        return nil
    }
    
    func validateSum() -> Bool {
        return getSum() == 100
    }
    
    func create() {
        
        if !validateSum() {
            // does not add up to 100
            errorString = "Your allocations add up to \(getSum()) not 100. They must add up to 100."
            showError = true
            showAlert = true
            return
        }
        
        if Date().timeIntervalSince1970 < date.timeIntervalSince1970 {
            errorString = "The specified date must be in the future."
            showError = true
            showAlert = true
        }
        
        let prop = classes.map { AllocationProportion(
            asset: Asset(name: $0.0.obj._class.typ.rawValue, _class: $0.0.obj._class, annualizedPerformance: $0.0.obj.apy),
            proportion: $0.1.obj) }
        
        let alloc = Allocation(id: MongoObjectID(oid: ""),
                               description: "",
                               date: Int(date.timeIntervalSince1970),
                               schema: prop)
        
        PlansService.newAllocation(payload: alloc) { (success, _, _, response) in
            if let _ = response {
                // success
                self.showSuccess = true
                self.showError = false
                self.showAlert = true
            }
        }
        
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
