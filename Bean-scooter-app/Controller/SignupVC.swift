//
//  SignupVC.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/23/24.
//

import UIKit


class SignupVC: UIViewController {
    
    
    
    //Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    
    //Textfields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //All textfield set up
    func setupAllTF() {
        nameTextField.placeholder = "닉네임을 입력하세요"
        nameTextField.keyboardType = UIKeyboardType.emailAddress
        nameTextField.clearButtonMode = .always
        nameTextField.becomeFirstResponder()
        
        idTextField.placeholder = "ID를 입력하세요"
        idTextField.keyboardType = UIKeyboardType.emailAddress
        idTextField.clearButtonMode = .always
        
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.clearButtonMode = .always
    }
    
    
    //Buttons
    @IBOutlet weak var adreeButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllTF()
        
    }
    
    
    
}
