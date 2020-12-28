//
//  PlansService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation

struct PlansService {

    static func events(completion: @escaping ((Bool, Error?, Any?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let body: [String: Any] = [
            "cookie": CredentialsObject.shared.jwt
        ]

        let jsonBody = try? JSONSerialization.data(withJSONObject: body)

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
            guard let urlResponse = urlResponse, let data = data else {
                completion(false, error, nil)
                return
            }
            
           
            
            completion(true, nil, nil)
            return
        }

        task.resume()

    }

    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/plans"

        return URL(string: address)
    }

}
