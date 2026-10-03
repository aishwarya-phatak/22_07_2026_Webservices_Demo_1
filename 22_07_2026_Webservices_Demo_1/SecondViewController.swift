//
//  SecondViewController.swift
//  22_07_2026_Webservices_Demo_1
//
//  Created by Vishal Jagtap on 03/10/26.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var userBodyLabel: UILabel!
    
    var userContainer : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extractAndBindData()
    }
    
    func extractAndBindData(){
        self.userIdLabel.text = "\(userContainer!.userId)"
        self.userTitleLabel.text = userContainer?.title
        self.userBodyLabel.text = userContainer?.body
    }
}
