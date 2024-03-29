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
    
    @Published var ids: [UUID] = []
    @Published var classes: [UUID: (Iden<AssetClassAndApy>, Iden<Double>)] = [:]
    
    @Published var classTypes: [Iden<AssetClassAndApy>] = []
    
    @Published var name: String = ""
    
    @Published var shouldPop: Bool = false
    
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
        
        for id in ids {
            if let obj = classes[id] {
                sum += Int(obj.1.obj)
            }
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
        
        // Is the date invalid
        if Date().timeIntervalSince1970 >= date.timeIntervalSince1970 {
            errorString = "The specified date must be in the future."
            showError = true
            showAlert = true
            return
        }
        
        if name.count == 0 {
            errorString = "The name must be non-empty."
            showError = true
            showAlert = true
            return
        }
        
        var schema: [AllocationProportion] = []
        
        for id in ids {
            if let obj = classes[id] {
                
                schema.append(AllocationProportion(
                                asset: Asset(name: obj.0.obj._class.typ.rawValue, _class: obj.0.obj._class, annualizedPerformance: obj.0.obj.apy),
                                proportion: obj.1.obj))
                
            }
        }
        
        let alloc = Allocation(id: nil,
                               description: name,
                               date: Int(date.timeIntervalSince1970),
                               schema: schema)
        
        PlansService.newAllocation(payload: alloc) { (success, _, _, response) in
            DispatchQueue.main.async {
                if let _ = response {
                    // success
                    self.shouldPop = true
                }else {
                    self.showError = true
                    self.errorString = "Server error. Please try again."
                    self.showAlert = true
                }
            }
        }
        
    }
    
    func newClass() {
        if classTypes.count == 0 {
            return
        }
        
        let nid = UUID()
        
        ids.append(nid)
        classes.updateValue((classTypes[0], Iden<Double>(obj: 0)), forKey: nid)
    }
    
    func delete(uuid: UUID) {
        ids.removeAll(where: { $0 == uuid })
        classes.removeValue(forKey: uuid)
    }
    
}
