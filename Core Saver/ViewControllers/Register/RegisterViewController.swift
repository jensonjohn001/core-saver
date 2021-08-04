//
//  RegisterViewController.swift
//  Core Saver
//
//  Created by MacBook on 8/3/21.
//

import UIKit
import SwiftSignatureView

class RegisterViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var signatureView: SwiftSignatureView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var firstNameInfoLabel: UILabel!
    @IBOutlet weak var lastNameInfoLabel: UILabel!
    @IBOutlet weak var phoneNumberInfoLabel: UILabel!
    @IBOutlet weak var dobInfoLabel: UILabel!
    
    var selectedDate:Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}
//MARK:- Private functions
private extension RegisterViewController{
    func configureView(){
        
        configureSignatureView()
        configureButtons([submitButton,listButton])
        configureButtons([selectDateButton], radius: 2)
    }
    
    func configureSignatureView(){
        signatureView.delegate = self
        signatureView.layer.borderWidth = 0.2
        signatureView.layer.cornerRadius = 1
        signatureView.layer.borderColor = (UIColor(named: "SignatureStrokeColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor
    }
    func configureButtons(_ views: [UIView], radius: CGFloat = 10){
        for view in views{
            view.layer.borderWidth = 0.2
            view.layer.cornerRadius = radius
            view.layer.borderColor = (UIColor(named: "SignatureStrokeColor") ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).cgColor
        }
    }
    
    func showDatePicker(){
        let vc = DatePickerViewController()
        vc.delegate = self
        vc.selectedDate = self.selectedDate
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 400, height: 300)
        vc.popoverPresentationController?.permittedArrowDirections = [.up, .left]
        vc.popoverPresentationController?.sourceView = self.selectDateButton
        vc.popoverPresentationController?.sourceRect = self.selectDateButton.bounds
        self.present(vc, animated: true)
    }
    
    func clearAll(){
        firstNameTextField.text = nil
        lastNameTextField.text = nil
        phoneNumberTextField.text = nil
        
        self.selectDateButton.setTitle("Select date", for: .normal)
        firstNameInfoLabel.isHidden = true
        lastNameInfoLabel.isHidden = true
        phoneNumberInfoLabel.isHidden = true
        
        signatureView.clear()
        clearButton.isHidden = true
    }
    
    func validate(){
        if let firstName = firstNameTextField.text?.trim(), firstName.isValidName(){
            firstNameInfoLabel.isHidden = true
        }else{
            firstNameInfoLabel.isHidden = false
        }
        if let lastName = self.lastNameTextField.text?.trim(), lastName.isValidName(){
            lastNameInfoLabel.isHidden = true
        }else{
            lastNameInfoLabel.isHidden = false
        }
        if let phoneNumber = self.phoneNumberTextField.text?.trim(), phoneNumber.isValidPhone(){
            phoneNumberInfoLabel.isHidden = true
        }else{
            phoneNumberInfoLabel.isHidden = false
        }
        if let dob = self.selectDateButton.title(for: .normal), dob != "Select date"{
            dobInfoLabel.isHidden = true
        }else{
            dobInfoLabel.isHidden = false
        }
    }
    
    func isValidForm()->Bool{
        
        guard let firstName = firstNameTextField.text?.trim(), firstName.isValidName() else {
            firstNameTextField.becomeFirstResponder()
            return false
        }
        guard let lastName = self.lastNameTextField.text?.trim(), lastName.isValidName() else{
            lastNameTextField.becomeFirstResponder()
            return false
        }
        guard let phoneNumber = self.phoneNumberTextField.text?.trim(), phoneNumber.isValidPhone() else{
            phoneNumberTextField.becomeFirstResponder()
            return false
        }
        guard let dob = self.selectDateButton.title(for: .normal), dob != "Select date" else{
            self.view.endEditing(true)
            showDatePicker()
            return false
        }
        return true
    }
    
    func performSaveAction(){
        
        validate()
        if isValidForm(){
            //createPDF()
            guard let firstName = firstNameTextField.text?.trim(), firstName.isValidName() else {
                return
            }
            guard let lastName = self.lastNameTextField.text?.trim(), lastName.isValidName() else{
                return
            }
            guard let phoneNumber = self.phoneNumberTextField.text?.trim(), phoneNumber.isValidPhone() else{
                return
            }
            let dob = self.selectDateButton.title(for: .normal) ?? "N/A"
            let user = User(firstName: firstName, lastName: lastName, dateOfBirth: dob, phoneNumber: phoneNumber)
            CoreDataManager.shared.openDatabaseAndSave(user: user, view: self.scrollContentView)
            
            self.clearAll()
            Utilities.showAlert(view: self, title: "Success", message: "User successfully registered!")
            
            
        }
    }
    
    func createPDF(){
        let pdfFilePath = self.scrollContentView.exportAsPdfFromView()
        print(pdfFilePath)
    }
}

//MARK:- Button actions
private extension RegisterViewController{
    @IBAction func clearButtonAction(_ sender: UIButton){
        signatureView.clear()
        clearButton.isHidden = true
    }
    @IBAction func submitButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
        performSaveAction()
        
    }
    @IBAction func listButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
        let vc = UsersListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func selectDateButtonAction(_ sender: UIButton){
        self.view.endEditing(true)
        showDatePicker()
    }
}
extension RegisterViewController: DatePickerViewControllerDelegate{
    func didChoose(date: Date) {
        self.selectedDate = date
        self.selectDateButton.setTitle(date.toString(), for: .normal)
    }
}
//MARK:- SwiftSignatureViewDelegate
extension RegisterViewController: SwiftSignatureViewDelegate{
    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        clearButton.isHidden = false
    }
    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {
        clearButton.isHidden = false
    }
    
}
