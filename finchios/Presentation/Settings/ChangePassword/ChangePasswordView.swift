//
//  ChangePasswordView.swift
//  finchios
//
//  Created by Brett Fazio on 2/24/21.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var model = ChangePasswordModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
