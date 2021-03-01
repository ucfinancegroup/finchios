//
//  NumberField.swift
//  finchios
//
//  Created by Brett Fazio on 2/3/21.
//

import SwiftUI

struct NumberField: UIViewRepresentable {
    
    @Binding var text: String
    
    var alignment: NSTextAlignment
    var keyType: UIKeyboardType
    var placeholder: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            if let unwrap = textField.text {
                self.text.wrappedValue = unwrap
            }else {
                self.text.wrappedValue = ""
            }
        }
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = keyType
        textfield.placeholder = placeholder
        
        textfield.delegate = context.coordinator
        
        textfield.textAlignment = alignment
        
        textfield.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)

        
        textfield.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        toolBar.items = [doneButton]
        toolBar.setItems([doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        uiView.text = text
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}
