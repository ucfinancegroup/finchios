//
//  GoalsService.swift
//  finchios
//
//  Created by Brett Fazio on 1/15/21.
//

import Foundation
import OpenAPIClient

struct GoalsService {
    
    public static func goals(completion: @escaping ((Bool, Error?, [GoalAndStatus]?) -> Void)) {
        guard let url = getAllGoalsURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode([GoalAndStatus].self, from: data) else {
                completion(false, error, nil)
                return
            }

            completion(true, nil, response)
            
            return
        }

        task.resume()

    }
    
    private static func getAllGoalsURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/goals"

        return URL(string: address)
    }
    
}

// POST goal/new
extension GoalsService {
    
    public static func newGoal(payload: GoalNewPayload, completion: @escaping ((Bool, Error?, GoalAndStatus?) -> Void)) {
        guard let url = getNewGoalURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let jsonBody = try? JSONEncoder().encode(payload)

        guard let unwrappedJsonBody = jsonBody else {
            completion(false, nil, nil)
            return
        }

        request.httpBody = unwrappedJsonBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(GoalAndStatus.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getNewGoalURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/goal/new"
        
        return URL(string: address)
    }
    
}

// DELETE goal/{id}
extension GoalsService {
    
    public static func deleteGoal(id: String, completion: @escaping ((Bool, Error?, GoalAndStatus?) -> Void)) {
        guard let url = getDeleteGoalURL(id: id) else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(GoalAndStatus.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getDeleteGoalURL(id: String) -> URL? {
        let address = "\(BusinessConstants.SERVER)/goal/\(id)"
        
        return URL(string: address)
    }
    
}

// Update
// PUT goal/{id}
extension GoalsService {
    
    public static func updateGoal(id: String, payload: GoalNewPayload, completion: @escaping ((Bool, Error?, GoalAndStatus?) -> Void)) {
        guard let url = getUpdateGoalURL(id: id) else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let jsonBody = try? JSONEncoder().encode(payload)

        guard let unwrappedJsonBody = jsonBody else {
            completion(false, nil, nil)
            return
        }

        request.httpBody = unwrappedJsonBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(GoalAndStatus.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getUpdateGoalURL(id: String) -> URL? {
        let address = "\(BusinessConstants.SERVER)/goal/\(id)"
        
        return URL(string: address)
    }
    
}
