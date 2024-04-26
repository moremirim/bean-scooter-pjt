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
    
    func setuplabel() {
        let mainColor = UIColor(red: 0x75 / 255.0, green: 0xCE / 255.0, blue: 0xE9 / 255.0, alpha: 1.0)
        profileNameLabel.text = myName
        profileNameLabel.textColor = .black
        profileIDLabel.text = myID
        profileIDLabel.textColor = mainColor
    }
    
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
        // TextField 입력된 텍스트가 빈 문자열인지 확인
        guard let newName = nameTextField.text, !newName.isEmpty,
        let newid = idTextField.text, !newid.isEmpty else {
            showAlert(message: "모든 필드에 내용을 입력하세요.")
            return
        }
        // 이름,id 중복 방지
        if AccountModel.accountModel.accountInfoArr.contains(where: { $0.userName == newName }) {
            showAlert(message: "'\(newName)'은 이미 사용중인 이름입니다.")
            return
        }
        if AccountModel.accountModel.accountInfoArr.contains(where: { $0.iD == newid }) {
            showAlert(message: "'\(newid)'은 이미 사용중인 id입니다.")
            return
        }
        //변경 확인알럿 생성
        let alert = UIAlertController(title: "알림", message: "프로필을 변경하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let index = AccountModel.accountModel.accountInfoArr.firstIndex(where: { $0.userName == self.myName }) {
                AccountModel.accountModel.accountInfoArr[index].userName = newName
                AccountModel.accountModel.accountInfoArr[index].iD = newid
            }
            guard let SignInVC = self.storyboard?.instantiateViewController(identifier: "SignInVC") else {return}
            self.navigationController?.pushViewController(SignInVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        /*구현기능 설명
         1. 입력값 여부 확인, 중복 확인
         2. 1이 아닐경우 확인 알럿 생성.
         3. 알럿창 > 확인버튼을 누르면 변경된 정보가 반영되고 signin 화면으로 이동.
         */
    }
    
    @IBAction func deleteaccountButton(_ sender: Any) {
        let alert = UIAlertController(title: "알림", message: "계정을 삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let index = AccountModel.accountModel.accountInfoArr.firstIndex(where: { $0.userName == self.myName }) {
                        AccountModel.accountModel.accountInfoArr.remove(at: index)
                guard let SignInVC = self.storyboard?.instantiateViewController(identifier: "SignInVC") else {return}
                self.navigationController?.pushViewController(SignInVC, animated: true)
                    }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        /*구현기능 설명
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuplabel()
        setupTextField()
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
