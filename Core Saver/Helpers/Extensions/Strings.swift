//
//  Strings.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import Foundation

extension String {
    func isValidName() -> Bool{
        let regex = try? NSRegularExpression(pattern: "^[\\p{L}\\.]{2,30}(?: [\\p{L}\\.]{2,30}){0,2}$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    func isValidPhone() -> Bool {
    
        let phoneNumber = self.trim()
        let PHONE_REGEX = "[0-9]{10,14}$"
        let phone = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phone.evaluate(with: phoneNumber)
        return result
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
