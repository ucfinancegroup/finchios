//
//  SignUpService.swift
//  finchios
//
//  Created by Brett Fazio on 12/27/20.
//

import Foundation

struct SignUpService {

    static func signUp(email: String, firstName: String, lastName: String, password: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = getSignUpURL() else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]

        
        let body: [String: Any] = [
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "password": password,
            "income": 5
        ]

        let jsonBody = try? JSONSerialization.data(withJSONObject: body)

        guard let unwrappedJsonBody = jsonBody else {
            completion(false)
            return
        }

        request.httpBody = unwrappedJsonBody

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false)
                return
            }
            
     
            // TODO(): Get the cookie and set it in a singleton
            completion(true)
            return

        }

        task.resume()

    }

    private static func getSignUpURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/signup"

        return URL(string: address)
    }

}
