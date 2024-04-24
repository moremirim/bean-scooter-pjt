//
//  RentViewController.swift
//  Bean-scooter-app
//
//  Created by 박미림 on 4/23/24.
//

import UIKit

class RentViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func didTapRentButton(_ sender: Any) {
        let rentProcessAlert = UIAlertController(title: "대여 확인", message: "기기의 시리얼 번호를 입력해주세요", preferredStyle: .alert)
        
        rentProcessAlert.addTextField() { (tf) in
            tf.placeholder = "Serial No."}
        
        let acccept = UIAlertAction(title: "대여하기", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let provedAccept = UIAlertAction(title: "기기 대여가 완료되었습니다", style: .default)
        
        rentProcessAlert.addAction(cancel)
        rentProcessAlert.addAction(acccept)
        present(rentProcessAlert, animated: true, completion: nil)
    }

}
