//
//  SignUpService.swift
//  finchios
//
//  Created by Brett Fazio on 12/27/20.
//

import Foundation
import OpenAPIClient
import CoreLocation

struct SignUpService {

    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "YYYY-MM-dd"
        return f
    }()
    
    static func signUp(signupPayload: SignupPayload, completion: @escaping ((Bool, Error?, String?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let encoder = JSONEncoder()
        
        // Expects a string of yyyy/MM/dd for json.
        encoder.dateEncodingStrategy = .formatted(SignUpService.formatter)
        
        let jsonBody = try? encoder.encode(signupPayload)

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
            
            if httpResponse.statusCode != 200 {
                completion(false, error, nil)
                return
            }
     
            let split = cookie.split(separator: ";")
            let sid = String(split[0])
            
            DispatchQueue.main.async {
                _ = CredentialsObject.resetCredentials(jwt: sid,
                                                       email: signupPayload.email,
                                                       password: signupPayload.password)
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
