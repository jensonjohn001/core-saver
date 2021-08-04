//
//  UIView.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit

extension UIView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) 
        self.layer.masksToBounds = true
    }
    
    func setBorder(){
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 1
        self.layer.borderColor = (UIColor(named: "SignatureStrokeColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor
    }
}

extension UIView {
    
    // Export pdf from Save pdf in directory and return pdf file path
    func exportAsPdfFromView() -> (path:String, fileName: String) {
        
        let pdfPageFrame = self.bounds
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return ("","") }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        return self.saveViewPdf(data: pdfData)
        
    }
    
    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> (path:String, fileName: String) {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let currentTimeStamp = String(Int(Date().timeIntervalSince1970))
        let randomPDFName = "pdf_\(currentTimeStamp).pdf"
        let pdfPath = docDirectoryPath.appendingPathComponent(randomPDFName)
        if data.write(to: pdfPath, atomically: true) {
            return (pdfPath.path, randomPDFName)
        } else {
            return ("", "")
        }
    }
}

extension UITableViewCell {
    
    // Fetch controller name
    static var identifier: String {
        
        return String(describing: self).components(separatedBy: ".").last!
    }
}
