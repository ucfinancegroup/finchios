//
//  TimeseriesService.swift
//  finchios
//
//  Created by Brett Fazio on 2/1/21.
//

import Foundation
import OpenAPIClient

// GET /timeseries/example and GET /timeseries
struct TimeSeriesService {
    
    public static func get(completion: @escaping ((Bool, Error?, TimeSeriesResponse?) -> Void)) {
        guard let url = getURL() else {
            completion(false, nil, nil)
            return
        }
        
        template(url: url) { (success, error, response) in
            completion(success, error, response)
        }
    }
    
    public static func example(completion: @escaping ((Bool, Error?, TimeSeriesResponse?) -> Void)) {
        guard let url = getExampleURL() else {
            completion(false, nil, nil)
            return
        }
        
        template(url: url) { (success, error, response) in
            completion(success, error, response)
        }
    }
    
    public static func template(url: URL, completion: @escaping ((Bool, Error?, TimeSeriesResponse?) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(TimeSeriesResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }
        
        task.resume()
    }
    
    private static func getExampleURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/timeseries/example"
        
        return URL(string: address)
    }
    
    private static func getURL(years: Int) -> URL? {
        let address = "\(BusinessConstants.SERVER)/timeseries/\(years * 365)"
        
        return URL(string: address)
    }
    
    // Default to 80 years like the web app
    private static func getURL() -> URL? {
        return getURL(years: 20)
    }
    
}
