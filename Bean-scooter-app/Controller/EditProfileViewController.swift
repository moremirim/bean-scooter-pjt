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
    
    var myName = ""
    var myID = ""
    
    //edit name view
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    //edit id view
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    
    //텍스트필드 셋업
    func setupTextField() {
        nameTextField.placeholder = "\(myName)"
        nameTextField.keyboardType = UIKeyboardType.emailAddress
        nameTextField.clearButtonMode = .always
        nameTextField.becomeFirstResponder()
        
        idTextField.placeholder = "\(myID)"
        idTextField.keyboardType = UIKeyboardType.emailAddress
        idTextField.clearButtonMode = .always
    }
    //키보드 로직
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            idTextField.becomeFirstResponder()
        }
        else if textField == idTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    //Buttons
    @IBAction func submitButton(_ sender: Any) {
        // nameTextField에 입력된 텍스트가 빈 문자열인지 확인
        guard let newName = nameTextField.text, !newName.isEmpty else {
            showAlert(message: "이름을 입력하세요.")
            return
        }
        
        // AccountModel에서 myName과 일치하는 userName을 가진 정보를 찾음
            if let index = AccountModel.accountModel.accountInfoArr.firstIndex(where: { $0.userName == myName }) {
            // 찾은 인덱스의 userName을 newName으로 업데이트
            AccountModel.accountModel.accountInfoArr[index].userName = newName
        }
        
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
    
    //알럿
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
