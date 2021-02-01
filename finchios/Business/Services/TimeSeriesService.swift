//
//  TimeseriesService.swift
//  finchios
//
//  Created by Brett Fazio on 2/1/21.
//

import Foundation
import OpenAPIClient

// GET /timeseries/example
struct TimeSeriesService {
    
    public static func example(completion: @escaping ((Bool, Error?, TimeSeries?) -> Void)) {
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
            
            guard let response = try? JSONDecoder().decode(TimeSeries.self, from: data) else {
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
    
}

// GET /timeseries
