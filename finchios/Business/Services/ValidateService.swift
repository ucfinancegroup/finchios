//
//  ValidateService.swift
//  finchios
//
//  Created by Brett Fazio on 2/7/21.
//

import Foundation
import OpenAPIClient

// POST /validate/user
struct ValidateService {
    
    public static func validate(payload: ValidateUserPayload, completion: @escaping ((Bool, Error?, String?) -> Void)) {
        guard let url = getUserURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let jsonBody = try? JSONEncoder().encode(payload)

        guard let unwrappedJsonBody = jsonBody else {
            completion(false, nil, nil)
            return
        }

        request.httpBody = unwrappedJsonBody
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            print(urlResponse)
            print(error)
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(false, error, nil)
                return
            }
            
            if httpResponse.statusCode != 200 {
                completion(false, error, nil)
                return
            }else {
                completion(true, nil, "Passing")
                return
            }
        }

        task.resume()
    }
    
    private static func getUserURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/validate/user"
        
        return URL(string: address)
    }
    
}
