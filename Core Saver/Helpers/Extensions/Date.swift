//
//  Date.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import Foundation
extension Date{
    func toString(format: String = "dd-MMM-yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
