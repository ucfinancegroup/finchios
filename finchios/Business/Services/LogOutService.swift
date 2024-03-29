//
//  LogOutService.swift
//  finchios
//
//  Created by Brett Fazio on 1/27/21.
//

import Foundation

// Logout route needs to be implemented first.
struct LogOutService {

    static func logOut(completion: @escaping ((Bool, Error?, String?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false, error, nil)
                return
            }
            guard let urlResponse = urlResponse, let _ = data else {
                completion(false, error, nil)
                return
            }
            
            guard urlResponse is HTTPURLResponse else {
                completion(false, error, nil)
                return
            }
            
            DispatchQueue.main.async {
                _ = CredentialsObject.resetCredentials(jwt: "_",
                                                       email: "_",
                                                       password: "_")
                
                completion(true, nil, nil)
                return
            }

        }

        task.resume()

    }

    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/logout"

        return URL(string: address)
    }

}
