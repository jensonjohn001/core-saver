//
//  ViewPDFViewController.swift
//  Core Saver
//
//  Created by MacBook on 8/4/21.
//

import UIKit
import PDFKit

class ViewPDFViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var pdfView: PDFView!
    var pdfURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        if let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
    }

}
//MARK:- Button actions
private extension ViewPDFViewController{
    @IBAction func backButtonAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
