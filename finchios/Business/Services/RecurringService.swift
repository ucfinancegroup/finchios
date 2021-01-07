//
//  RecurringService.swift
//  finchios
//
//  Created by Brett Fazio on 1/7/21.
//

import Foundation
import OpenAPIClient

// GET recurrings
struct RecurringService {
    
    private static func helper(operand: @escaping (Int, Int) -> Bool, completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
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
    
    
    public static func incomes(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        // Greater than 0
        helper(operand: >) { (success, error, result) in
            completion(success, error, result)
        }
    }
    
    public static func expenses(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        // Less than 0
        helper(operand: <) { (success, error, result) in
            completion(success, error, result)
        }
    }
    
    private static func recurrings(completion: @escaping ((Bool, Error?, [Recurring]?) -> Void)) {
        guard let url = getAllRecurringURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["cookie": CredentialsObject.shared.jwt]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false, error, nil)
                return
            }
            guard let _ = urlResponse, let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode([Recurring].self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            
            completion(true, nil, nil)
            return
        }

        task.resume()

    }
    
    private static func getAllRecurringURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/recurrings"

        return URL(string: address)
    }
    
}

// POST recurring/new
extension RecurringService {
    
    private static func getNewRecurringURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/recurring/new"
        
        return URL(string: address)
    }
    
}
