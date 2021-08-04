//
//  CoreDataManager.swift
//  Core Saver
//
//  Created by MacBook on 8/3/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    enum Keys: String{
        case users = "Users"
        
        case firstName = "firstName"
        case lastName = "lastName"
        case dateOfBirth = "dateOfBirth"
        case phoneNumber = "phoneNumber"
        case pdfLocation = "pdfLocation"
        
        var value: String {
            return self.rawValue
        }
    }
    
    //MARK: Declarations
    static let shared = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singleton instance
    var context:NSManagedObjectContext!
    let entityName = Keys.users.value
    
    // MARK: Life Cycle
    private override init() {
        super.init()
        
    }
    
}
extension CoreDataManager{
    
    // MARK: Methods to Open, Store and Fetch data
    func openDatabaseAndSave(user: User, view: UIView)
    {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newUser, user: user, view: view)
    }
    
    func saveData(UserDBObj:NSManagedObject, user: User, view: UIView)
    {
        
        let pdfFilePath = view.exportAsPdfFromView().fileName
        
        let firstName = user.firstName
        let lastName = user.lastName
        let dob = user.dateOfBirth
        let phoneNumber = user.phoneNumber
        let pdfLocation = pdfFilePath
        
        UserDBObj.setValue(firstName, forKey: Keys.firstName.value)
        UserDBObj.setValue(lastName, forKey: Keys.lastName.value)
        UserDBObj.setValue(dob, forKey: Keys.dateOfBirth.value)
        UserDBObj.setValue(phoneNumber, forKey: Keys.phoneNumber.value)
        UserDBObj.setValue(pdfLocation, forKey: Keys.pdfLocation.value)
        
        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
        
        let users = fetchUsersList()
        print(users)
    }
    
    func fetchUsersList()->[User]{
        var usersList = [User]()
        print("Fetching Data..")
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let firstName = (data.value(forKey: Keys.firstName.value) as? String) ?? "N/A"
                let lastName = (data.value(forKey: Keys.lastName.value) as? String) ?? ""
                let dob = (data.value(forKey: Keys.dateOfBirth.value) as? String) ?? "N/A"
                let ph = (data.value(forKey: Keys.phoneNumber.value) as? String) ?? "N/A"
                let pdfLoc = (data.value(forKey: Keys.pdfLocation.value) as? String) ?? "N/A"
                let user = User(firstName: firstName, lastName: lastName, dateOfBirth: dob, phoneNumber: ph, pdfLoc: pdfLoc)
                usersList.append(user)
            }
            
        } catch {
            print("Fetching data Failed")
        }
        return usersList
    }
    
    func createPDF(){
        
    }
    
    
    func deleteAllData(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let arrUsrObj = try context.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                context.delete(usrObj)
            }
            try context.save() //don't forget
        } catch let error as NSError {
            print("delete fail--",error)
        }
        
    }
    
}
extension CoreDataManager{
    func createPDF(view: UIView){
        let pdfFilePath = view.exportAsPdfFromView()
        print(pdfFilePath)
    }
}
