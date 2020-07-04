//
//  ViewController+InputValidation.swift
//  PayTabsAssignment
//
//  Created by N, Azik Abdullah (Cognizant) on 04/07/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import Foundation
extension ViewController {
    func validateAllInputs() -> String {
        if validateAllTextFieldEntered() == false {
            return "All fields are Mandatory"
        } else if validateEmail() == false {
            return "Enter Valid Email address"
        } else if validateAmount() == false {
            return "Enter Valid Amount"
        } else if validatePhone() == false {
            return "Enter Valid Mobile Number"
        }
        
        return "valid"
    }
    
    func validateAllTextFieldEntered()-> Bool {
        if customerEmailTextField.text == "" || customerNameTextField.text == ""  || amountTextField.text == "" || orderIDTextField.text == "" || shippingCityTextField.text == "" || shippingStateTextField.text == "" || shippingAddressTextField.text == "" || shippingCountryTextField.text == "" || shippingZipCodeTextField.text == "" || billingCityTextField.text == "" || billingStateTextField.text == "" || billingCountryTextField.text == "" || billingZipCodeTextField.text == "" || bilingAddressTextField.text == "" || customerMobileNumberTextField.text == ""{
            return false
        }
        return true
    }
    
    func validateEmail() -> Bool {
        if let enteredEmail = customerEmailTextField.text {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            if emailPredicate.evaluate(with: enteredEmail) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func validatePhone() -> Bool {
        if let enteredMobileNumber = customerMobileNumberTextField.text {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: enteredMobileNumber)
        } else {
            return false
        }
    }
    
    func validateAmount() -> Bool {
        if let enteredAmount:String = amountTextField.text {
            let amount = Float(enteredAmount)
            if amount == 0.0 || amount == nil {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "CheckOut", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


              @unknown default: break
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }

}
