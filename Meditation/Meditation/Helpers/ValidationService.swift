//
//  ValidationService.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 8.10.21.
//

import Foundation

class ValidationService {
    static let shared = ValidationService()
    
    private init() { }
    
    func isValidPassword(_ password: String) -> Bool {
        if password.count > 3 {
            return true
        }
        
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
