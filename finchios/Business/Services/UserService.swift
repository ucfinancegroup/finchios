//
//  UserService.swift
//  finchios
//
//  Created by Brett Fazio on 2/24/21.
//

import Foundation
import OpenAPIClient

struct UserService {
    
    public static func update(payload: UpdateUserRequest, completion: @escaping ((Bool, Error?, User?) -> Void)) {
        guard let url = getUpdateURL() else {
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
            
            guard let response = try? JSONDecoder().decode(User.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getUpdateURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/update/user"
        
        return URL(string: address)
    }
    
}

// get
extension UserService {
    
    public static func get(completion: @escaping ((Bool, Error?, User?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
            
            guard let response = try? JSONDecoder().decode(User.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/user"
        
        return URL(string: address)
    }
    
}
