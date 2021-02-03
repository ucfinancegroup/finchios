//
//  UIApplication.swift
//  finchios
//
//  Created by Brett Fazio on 2/3/21.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
