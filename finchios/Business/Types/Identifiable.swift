//
//  Identifiable.swift
//  finchios
//
//  Created by Brett Fazio on 1/24/21.
//

import Foundation

public struct Iden<T>: Identifiable {
    
    public var id = UUID()
    
    public var obj: T
    public var index: Int = 0
    
}
