//
//  UserTableViewCell.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var letterHolderView: UIView!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    //Set from parent
    var cellData: User?{
        didSet{
            populateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView(){
        letterHolderView.setBorder()
        letterHolderView.setRounded()
    }
    
    func populateUI(){
        DispatchQueue.main.async{
            guard let _cellData = self.cellData else { return }
            self.fullNameLabel.text = _cellData.fullName
            let firstName = _cellData.firstName.uppercased()
            let lastName = _cellData.lastName.uppercased()
            if firstName.count > 0{
                if lastName.count > 0{
                    self.letterLabel.text = "\(firstName.first ?? "-")\(lastName.first ?? "-")"
                }
            }
            self.phoneNumberLabel.text = _cellData.phoneNumber
        }
    }

}
