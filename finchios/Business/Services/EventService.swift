//
//  EventService.swift
//  finchios
//
//  Created by Brett Fazio on 3/17/21.
//

import Foundation
import OpenAPIClient

struct EventService {
    
    public static func example(completion: @escaping ((Bool, Error?, [Event]?) -> Void)) {
        guard let url = getExampleURL() else {
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
            
            guard let response = try? JSONDecoder().decode([Event].self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getExampleURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/event/examples"
        
        return URL(string: address)
    }
    
}
