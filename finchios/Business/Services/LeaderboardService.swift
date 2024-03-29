//
//  LeaderboardService.swift
//  finchios
//
//  Created by Brett Fazio on 12/28/20.
//

import Foundation
import OpenAPIClient

struct LeaderboardService {
    
    static func leaderboard(type: BoardType, completion: @escaping ((Bool, Error?, Ranking?) -> Void)) {
        guard let url = getURL(type: type.rawValue) else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = [BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard data != nil else {
                completion(false, error, nil)
                return
            }
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(Ranking.self, from: data) else {
                completion(false, error, nil)
                return
            }
            
            completion(true, nil, response)
            return
        }

        task.resume()

    }
    
    private static func getURL(type: String) -> URL? {
        let address = "\(BusinessConstants.SERVER)/leaderboard/\(type)"

        return URL(string: address)
    }
    
}
