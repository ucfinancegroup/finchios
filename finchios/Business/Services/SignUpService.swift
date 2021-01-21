//
//  SignUpService.swift
//  finchios
//
//  Created by Brett Fazio on 12/27/20.
//

import Foundation

struct SignUpService {

    static func signUp(email: String, firstName: String, lastName: String, password: String, completion: @escaping ((Bool, Error?, String?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
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
            guard let cookie = httpResponse.allHeaderFields[BusinessConstants.RESPONSE_COOKIE] as? String else {
                completion(false, error, nil)
                return
            }
     
            let split = cookie.split(separator: ";")
            let sid = String(split[0])
            
            DispatchQueue.main.async {
                _ = CredentialsObject.resetCredentials(jwt: sid,
                                                       email: email,
                                                       password: password)
            }

            completion(true, nil, cookie)
            return

        }

        task.resume()

    }

    private static func getURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/signup"

        return URL(string: address)
    }

}
