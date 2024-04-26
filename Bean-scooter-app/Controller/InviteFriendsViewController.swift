//
//  RecommendFriendsViewController.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/26/24.
//

import UIKit

class InviteFriendsViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoSubLabel: UILabel!
    
    
    @IBOutlet weak var codeInfoLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    
    var mycode = ""
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        // UIActivityViewController 생성
        let activityViewController = UIActivityViewController(activityItems: [mycode], applicationActivities: nil)
        
        // 팝오버 스타일로 표시되도록 설정
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // UIActivityViewController를 표시
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
