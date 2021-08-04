//
//  User.swift
//  Core Saver
//
//  Created by MacBook on 8/3/21.
//

import Foundation
struct User: Codable {
    
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var phoneNumber: String
    var pdfLocation: String?
    
    init(firstName: String, lastName: String, dateOfBirth: String, phoneNumber: String, pdfLoc: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.phoneNumber = phoneNumber
        self.pdfLocation = pdfLoc
    }
    var fullName: String{
        return ((firstName).trim() + " " + (lastName).trim()).trim()
    }
}
