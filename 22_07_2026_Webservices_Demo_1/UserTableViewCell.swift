//
//  UserTableViewCell.swift
//  22_07_2026_Webservices_Demo_1
//
//  Created by Vishal Jagtap on 02/10/26.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var userBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
}
