//
//  GuideTabeViewCellTableViewCell.swift
//  Bean-scooter-app
//
//  Created by 채나연 on 4/26/24.
//

import UIKit

class GuideTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var guideImage: UIImageView!
    
    @IBOutlet weak var guideText: UILabel!
    
    @IBOutlet weak var guideBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
