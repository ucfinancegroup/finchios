//
//  LogInService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation

struct LogInService {

    static func logIn(email: String, password: String, completion: @escaping ((Bool, Error?, String?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let body: [String: Any] = [
            "email": email,
            "password": password,
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
            guard let urlResponse = urlResponse, let _ = data else {
                completion(false, error, nil)
                return
            }
            
            let httpResponse = urlResponse as! HTTPURLResponse
            
            // TODO(): Parse out the token portion of the cookie
            let cookie = httpResponse.allHeaderFields["Set-Cookie"] as! String
     
            // TODO(): Get the cookie and set it in a singleton
            completion(true, nil, cookie)
            return
        }

        task.resume()

    }

    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/login"

        return URL(string: address)
    }

}
