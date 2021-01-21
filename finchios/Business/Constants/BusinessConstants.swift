//
//  BusinessConstants.swift
//  finchios
//
//  Created by Brett Fazio on 12/27/20.
//

import Foundation

struct BusinessConstants {
    #if RELEASE
    static let SERVER = "https://finchapp.eastus.cloudapp.azure.com/api"
    #else
    static let SERVER = "http://localhost:8080"
    #endif
    
    static let SET_COOKIE = "Cookie"
    static let RESPONSE_COOKIE = "Set-Cookie"
}
