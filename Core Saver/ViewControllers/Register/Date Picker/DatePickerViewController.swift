//
//  DatePickerViewController.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit
protocol DatePickerViewControllerDelegate: class{
    func didChoose(date: Date)
}
class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    //Set from parent
    weak var delegate: DatePickerViewControllerDelegate?
    var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    func configureView(){
        configureDatePicker()
    }
    
    func configureDatePicker(){
        datePicker.maximumDate = Date()
        datePicker.date = selectedDate
    }

    @IBAction func doneButtonAction(_ sender: UIButton){
        self.delegate?.didChoose(date: datePicker.date)
        self.dismiss(animated: true)
        
    }

}
