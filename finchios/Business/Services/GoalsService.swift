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
        
        request.allHTTPHeaderFields = [BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

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
