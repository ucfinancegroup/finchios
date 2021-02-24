//
//  InsightsService.swift
//  finchios
//
//  Created by Brett Fazio on 2/8/21.
//

import Foundation
import OpenAPIClient

// GET insights/examples
public struct InsightsService {
    
    public static func example(completion: @escaping ((Bool, Error?, [Insight]?) -> Void)) {
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
            
            guard let response = try? JSONDecoder().decode([Insight].self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getExampleURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/insights/examples"
        
        return URL(string: address)
    }
    
}

// GET /insights
extension InsightsService {
    
    public static func insights(completion: @escaping ((Bool, Error?, [Insight]?) -> Void)) {
        guard let url = getInsightsURL() else {
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
            
            guard let response = try? JSONDecoder().decode([Insight].self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getInsightsURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/insights"
        
        return URL(string: address)
    }
    
}

// PUT dismiss
extension InsightsService {
    
    public static func dismiss(id: String, completion: @escaping ((Bool, Error?, Insight?) -> Void)) {
        guard let url = getDismissURL(id: id) else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(Insight.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()
    }
    
    private static func getDismissURL(id: String) -> URL? {
        let address = "\(BusinessConstants.SERVER)/insight/\(id)/dismiss"
        
        return URL(string: address)
    }
    
}
