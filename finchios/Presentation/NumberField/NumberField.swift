//
//  NumberField.swift
//  finchios
//
//  Created by Brett Fazio on 2/3/21.
//

import SwiftUI

struct NumberField: UIViewRepresentable {
    
    var alignment: NSTextAlignment
    var keyType: UIKeyboardType
    var placeholder: String
    var changeHandler:((String)->Void)
    
    func makeUIView(context: Context) -> WrappableTextField {
        let textfield = WrappableTextField()
        textfield.keyboardType = keyType
        textfield.placeholder = placeholder
        
        textfield.delegate = textfield
        
        textfield.textFieldChangedHandler = changeHandler
        
        textfield.textAlignment = alignment
        
        
        textfield.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        toolBar.items = [doneButton]
        toolBar.setItems([doneButton], animated: true)
        textfield.inputAccessoryView = toolBar
        return textfield
    }
    
    func updateUIView(_ uiView: WrappableTextField, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}


class WrappableTextField: UITextField, UITextFieldDelegate {
    var textFieldChangedHandler: ((String)->Void)?
    var onCommitHandler: (()->Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentValue = textField.text as NSString? {
            let proposedValue = currentValue.replacingCharacters(in: range, with: string)
            textFieldChangedHandler?(proposedValue as String)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onCommitHandler?()
    }
}
