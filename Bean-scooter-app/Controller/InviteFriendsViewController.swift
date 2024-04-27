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
    
    func setuplabel() {
        codeLabel.text = mycode
    }
    
    @IBAction func copyButtonTapped(_ sender: UIButton) {
        // 클립보드에 mycode를 복사
        UIPasteboard.general.string = mycode
        
        // 알럿
        let alert = UIAlertController(title: "복사되었습니다", message: "친구에게 공유해보세요!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 공유하기 기능
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        // 클립보드에 복사된 내용 불러오기. 텍스트가 있을 경우에만 실행
        guard let copiedText = UIPasteboard.general.string else {
            return
        }
        
        // UIActivityViewController 생성하여 클립보드에 복사된 내용을 공유
        let activityViewController = UIActivityViewController(activityItems: [copiedText], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🐶", mycode)
        setuplabel()
        // Do any additional setup after loading the view.
    }
    
}
