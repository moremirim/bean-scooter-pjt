//
//  ScooterManageTableViewCell.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import UIKit

class ScooterManageTableViewCell: UITableViewCell {

    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var delteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        serialLabel.text = ""
    }
    
}
