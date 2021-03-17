//
//  AllocationEditModel.swift
//  finchios
//
//  Created by Brett Fazio on 3/4/21.
//

import Foundation
import OpenAPIClient

class AllocationEditModel: ObservableObject, Identifiable {
    
    @Published var showAlert: Bool = false
    @Published var success: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorString: String = ""

    // Fields
    @Published var ids: [UUID] = []
    @Published var classes: [UUID: (Iden<AssetClassAndApy>, Iden<Double>)] = [:]
    
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
    
    func set(alloc: Allocation) {
        // Set the classes & create IDs here.
    }
    
}
