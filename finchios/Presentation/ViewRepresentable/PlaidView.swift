//
//  ViewController.swift
//  finchios
//
//  Created by Brett Fazio on 12/17/20.
//

import SwiftUI
import LinkKit

struct PlaidView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIViewController

    var handler: Handler?

    init(withHandler handler: Handler) {
        self.handler = handler
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<PlaidView>) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        let presentationMethod = PresentationMethod.viewController(viewController)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            handler?.open(presentUsing: presentationMethod)
        })
        return viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<PlaidView>) {
        //
    }
}
