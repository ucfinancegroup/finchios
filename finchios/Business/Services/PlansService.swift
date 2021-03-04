//
//  PlansService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

struct PlansService: RecurringProtocol {

    private static func plans(completion: @escaping ((Bool, Error?, Plan?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false, error, nil)
                return
            }
            guard let _ = urlResponse, let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode([Plan].self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            guard let firstPlan = response.first else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, firstPlan)
            return
        }

        task.resume()

    }
    
    static func events(completion: @escaping ((Bool, Error?, [Event]?) -> Void)) {
        plans { (success, error, plan) in
            guard let plan = plan else {
                completion(success, error, nil)
                return
            }
            
            guard let events = plan.events else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, events)
            return
        }
    }
    
    //TODO() BUG() This should be an allocation not a transform
    static func allocations(completion: @escaping ((Bool, Error?, [Allocation]?) -> Void)) {
        plans { (success, error, plan) in
            guard let plan = plan else {
                completion(success, error, nil)
                return
            }
            
            guard let allocations = plan.allocations else {
                completion(false, error, nil)
                return
            }

            completion(true, nil, allocations)
            return
        }
    }
    
    static func recurrings(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        plans { (success, error, plan) in
            guard let plan = plan else {
                completion(success, error, nil)
                return
            }
            
            guard let recurrings = plan.recurrings else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, recurrings)
            return
        }
    }

    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/plan"

        return URL(string: address)
    }

}

// For getting incomes, debts, and expenses from plans recurring
extension PlansService {
    
    private static func income_helper(operand: @escaping (Double, Double) -> Bool, completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        recurrings { (success, error, result) in
            if let error = error {
                completion(false, error, nil)
                return
            }
            if !success {
                completion(false, error, nil)
                return
            }
            
            guard let result = result else {
                completion(false, error, nil)
                return
            }
            
            let incomes = result.filter( { operand($0.amount, 0) })
            
            completion(true, nil, incomes)
        }
    }
    
    private static func debt_helper(operand: @escaping (Double, Double) -> Bool, completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        recurrings { (success, error, result) in
            if let error = error {
                completion(false, error, nil)
                return
            }
            if !success {
                completion(false, error, nil)
                return
            }
            
            guard let result = result else {
                completion(false, error, nil)
                return
            }
            
            let incomes = result.filter( { operand($0.principal, 0) })
            
            completion(true, nil, incomes)
        }
    }
    
    public static func incomes(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        // Greater than 0
        income_helper(operand: >) { (success, error, result) in
            completion(success, error, result)
        }
    }
    
    public static func expenses(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        // Less than 0
        income_helper(operand: <) { (success, error, result) in
            completion(success, error, result)
        }
    }
    
    public static func debt(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        debt_helper(operand: <) { (success, error, result) in
            completion(success, error, result)
        }
    }
    
}

// For creating recurrings
extension PlansService {
    static func newRecurring(payload: RecurringNewPayload, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
    }
}

// For editing recurrings
extension PlansService {
    static func updateRecurring(id: String, payload: RecurringNewPayload, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
    }
}


// For deleting recrrings
extension PlansService {
    static func deleteRecurring(id: String, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
    }
}

// Creation/Editing/Deletion of Events
extension PlansService {
    
}
