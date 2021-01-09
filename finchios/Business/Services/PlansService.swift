//
//  PlansService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

struct PlansService {

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
            
            guard let response = try? JSONDecoder().decode(Plan.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            
            completion(true, nil, nil)
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
    //static func allocations(completion: @escaping ((Bool, Error?, [Allocation]?) -> Void)) {
    static func allocations(completion: @escaping ((Bool, Error?, [Any]?) -> Void)) {
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
        let address = "\(BusinessConstants.SERVER)/plans"

        return URL(string: address)
    }

}
