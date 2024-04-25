//
//  EditProfile.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/25/24.
//

import UIKit


class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileIDLabel: UILabel!
    
    //edit name view
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    //edit id view
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    
    
    
    //Buttons
    @IBAction func submitButton(_ sender: Any) {
        /*구현계획
         1. 확인 알럿 생성.
         2. 중복 확인 (확인알럿대신 중복안내 알럿 생성)
         3. 알럿창에서 확인버튼을 누르면 변경된 정보가 반영되고 마이페이지로 이동.
         */
    }
    
    @IBAction func deleteaccountButton(_ sender: Any) {
        /*구현계획
         1. 확인 알럿 생성.
         2. 알럿창에서 확인버튼을 누르면 계정 삭제 후 signin 화면으로 이동.
         */
    }
    
    
}
