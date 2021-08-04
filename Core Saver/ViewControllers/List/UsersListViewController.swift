//
//  UsersListViewController.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit

class UsersListViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var userTableView: UITableView!
    
    //Declarations
    var users = [User]()
    let cellIdentifier = UserTableViewCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }


}
//MARK:- Private functions
private extension UsersListViewController{
    
    func configureView(){
        configureTableView()
        fetchUsers()
    }
    
    func configureTableView(){
        self.userTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func fetchUsers(){
        users = CoreDataManager.shared.fetchUsersList()
        userTableView.reloadData()
    }
}

//MARK:- Button actions
private extension UsersListViewController{
    @IBAction func backButtonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK:- TableView delegates
extension UsersListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        if users.count > 0{
            let cellData = users[indexPath.row]
            cell.cellData = cellData
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if users.count > 0{
            let cellData = users[indexPath.row]
            let pdfFileName = cellData.pdfLocation ?? ""
            let vc = ViewPDFViewController()
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docDirectoryPath = paths[0]
            let pdfPath = docDirectoryPath.appendingPathComponent(pdfFileName)
            vc.pdfURL = pdfPath
            self.navigationController?.pushViewController(vc, animated: true)
           
        }
        
    }
}
