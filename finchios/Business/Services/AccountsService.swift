//
//  AccountsService.swift
//  finchios
//
//  Created by Brett Fazio on 1/22/21.
//

import Foundation
import OpenAPIClient

// GET /plaid/accounts
public struct AccountsService {
    
    public static func accounts(all: Bool, completion: @escaping ((Bool, Error?, AccountsResponse?) -> Void)) {
        guard let url = all ? getAllAccountsURL() : getUnhiddenAccountsURL() else {
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
            
            guard let response = try? JSONDecoder().decode(AccountsResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }

            completion(true, nil, response)
            
            return
        }

        task.resume()

    }
    
    private static func getAllAccountsURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/plaid/accounts/all"

        return URL(string: address)
    }
    
    private static func getUnhiddenAccountsURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/plaid/accounts/unhidden"

        return URL(string: address)
    }
    
}

// DELETE /plaid/account/{item_id}

extension AccountsService {
    public static func delete(itemID: String, completion: @escaping ((Bool, Error?, ItemIdResponse?) -> Void)) {
        guard let url = getAccountURL(itemID: itemID) else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(ItemIdResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }

            completion(true, nil, response)
            
            return
        }

        task.resume()

    }
    
    private static func getAccountURL(itemID: String) -> URL? {
        let address = "\(BusinessConstants.SERVER)/plaid/accounts/\(itemID)"

        return URL(string: address)
    }
    
}

// Hide/unhide PUT

extension AccountsService {
    public static func hide(payload: SetAccountAsHiddenPayload, completion: @escaping ((Bool, Error?, AccountsResponse?) -> Void)) {
        guard let url = getHideURL() else {
            completion(false, nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = ["Content-Type": "application/json",
                                       BusinessConstants.SET_COOKIE : CredentialsObject.shared.jwt]

        let jsonBody = try? JSONEncoder().encode(payload)
        
        guard let unwrappedJsonBody = jsonBody else {
            completion(false, nil, nil)
            return
        }
        
        request.httpBody = unwrappedJsonBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else {
                completion(false, error, nil)
                return
            }
            
            guard let response = try? JSONDecoder().decode(AccountsResponse.self, from: data) else {
                completion(false, error, nil)
                return
            }

            completion(true, nil, response)
            
            return
        }

        task.resume()

    }
    
    private static func getHideURL() -> URL? {
        let address = "\(BusinessConstants.SERVER)/plaid/accounts/hide"

        return URL(string: address)
    }
    
}
