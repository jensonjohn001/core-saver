//
//  UtilMethods.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit
class Utilities{
    static func showAlert(view: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            
        }))
        
        view.present(alert, animated: true, completion: nil)
    }
}
