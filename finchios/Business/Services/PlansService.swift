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
            
            guard let response = try? JSONDecoder().decode(PlanResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response.plan)
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
            
            completion(true, nil, plan.events)
            return
        }
    }
    
    static func allocations(completion: @escaping ((Bool, Error?, [Allocation]?) -> Void)) {
        plans { (success, error, plan) in
            guard let plan = plan else {
                completion(success, error, nil)
                return
            }
            
            completion(true, nil, plan.allocations)
            return
        }
    }
    
    static func recurrings(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        plans { (success, error, plan) in
            guard let plan = plan else {
                completion(success, error, nil)
                return
            }
            
            completion(true, nil, plan.recurrings)
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

// Plan update
extension PlansService {
    
    static func planUpdate(payload: PlanUpdatePayload, completion: @escaping ((Bool, Error?, PlanResponse?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.allHTTPHeaderFields = [BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt,
                                       "Content-Type": "application/json"]
        
        let jsonBody = try? JSONEncoder().encode(payload)
        
        guard let unwrappedJsonBody = jsonBody else {
            completion(false, nil, nil)
            return
        }
        
        request.httpBody = unwrappedJsonBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false, error, nil)
                return
            }
            guard let _ = urlResponse, let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(PlanResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
}

// For creating,editing,deleting recurrings
extension PlansService {
    
    static func newRecurring(payload: RecurringNewPayload, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
        PlansService.recurrings { (_, _, result) in
            if var existing = result {
                
                let newRec = Recurring(id: nil, name: payload.name, start: payload.start, end: payload.end, principal: payload.principal, amount: payload.amount, interest: payload.interest, frequency: payload.frequency)
                
                existing.append(newRec)
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: existing, allocations: nil, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func updateRecurring(id: String, payload: RecurringNewPayload, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
        PlansService.recurrings { (_, _, result) in
            if var existing = result {
                for index in 0..<existing.count {
                    if existing[index].id!.oid == id {
                        existing[index].name = payload.name
                        existing[index].amount = payload.amount
                        existing[index].principal = payload.principal
                        existing[index].frequency = payload.frequency
                        existing[index].interest = payload.interest
                        existing[index].start = payload.start
                        existing[index].end = payload.end
                    }
                }
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: existing, allocations: nil, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func deleteRecurring(id: String, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        PlansService.recurrings { (_, _, result) in
            if var existing = result {
                
                
                existing.removeAll { $0.id!.oid == id }
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: existing, allocations: nil, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
    }
}

// Creation/Editing/Deletion of Events
extension PlansService {
    
    static func newEvent(payload: Event, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        // Make sure send id is nil
        var send = payload
        send.id = nil
        
        PlansService.events { (_, _, result) in
            if var existing = result {
                
                existing.append(send)
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: nil, events: existing)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func updateEvent(id: String, payload: Event, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
        PlansService.events { (_, _, result) in
            if var existing = result {
                
                existing.removeAll { $0.id!.oid == id }
                
                var copy = payload
                
                copy.id!.oid = id
                
                existing.append(copy)
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: nil, events: existing)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func deleteEvent(id: String, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        PlansService.events { (_, _, result) in
            if var existing = result {
                
                existing.removeAll { $0.id!.oid == id }
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: nil, events: existing)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
    }
    
}

// Creation/editing/deletion of allocations
extension PlansService {
    
    static func newAllocation(payload: Allocation, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        // Make sure send id is nil
        var send = payload
        send.id = nil
        
        PlansService.allocations { (_, _, result) in
            if var existing = result {
                
                existing.append(send)
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: existing, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func updateAllocation(id: String, payload: Allocation, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        
        PlansService.allocations { (_, _, result) in
            if var existing = result {
                
                existing.removeAll { $0.id!.oid == id }
                
                var copy = payload
                
                copy.id!.oid = id
                
                existing.append(copy)
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: existing, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
        
    }
    
    static func deleteAllocation(id: String, completion: @escaping ((Bool, Error?, Recurring?, PlanResponse?) -> Void)) {
        PlansService.allocations { (_, _, result) in
            if var existing = result {
                
                existing.removeAll { $0.id!.oid == id }
                
                let update = PlanUpdatePayload(name: "Plan", recurrings: nil, allocations: existing, events: nil)
                
                PlansService.planUpdate(payload: update) { (success, error, response) in
                    completion(success, error, nil, response)
                }
            }
        }
    }
    
}
