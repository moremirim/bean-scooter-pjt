//
//  Heela'sVC.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/22/24.
//

import UIKit


class HeelaVC: UIViewController {

    
    //텍스트필드
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    func setupidTF() {
        idTextField.placeholder = "ID를 입력하세요"
        
        idTextField.keyboardType = UIKeyboardType.emailAddress //키보드타입
        idTextField.clearButtonMode = .always //텍스트를 입력할 때 모두 삭제할 수 있는 x아이콘
        idTextField.clearsOnBeginEditing = false //수정시 텍스트 전체삭제?
        //idTextField.returnKeyType = .continue //리턴버튼 타입 변경
        idTextField.becomeFirstResponder() //화면에서 첫번째로 이벤트 발생
    }
    func setuppwTF() {
        pwTextField.placeholder = "Password를 입력하세요"
        
        pwTextField.keyboardType = UIKeyboardType.emailAddress
        pwTextField.clearButtonMode = .always
        pwTextField.clearsOnBeginEditing = false
        pwTextField.isSecureTextEntry = true //텍스트 보안
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두 개의 텍스트필드 모두 종료 (키보드 내려가기)
        if idTextField.text != "", pwTextField.text != "" {
            pwTextField.resignFirstResponder()
            return true
            // 두 번 째 텍스트필드로 넘어간다.
        } else if idTextField.text != "" {
            pwTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    
    //Sign in 버튼
    @IBAction func signinButton(_ sender: Any) {
        //idTextField에 값이 입력되어있는지 확인
        guard let idText = idTextField.text, !idText.isEmpty else {
            showAlert(message: "ID를 입력하세요.")
            return
        }
        guard let pwText = pwTextField.text, !pwText.isEmpty else {
            showAlert(message: "Password를 입력하세요.")
            return
        }
        
        //입력된 id가 회원가입되어있을 경우, 텍스트필드 내용을 마이페이지로 보내고 다음화면으로 이동
        if let account = AccountModel.accountModel.accountInfoArr.first(where: { $0.iD == idText && $0.passWord == pwText }) {

            if let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapVC") as? MapViewController {

                self.navigationController?.pushViewController(mapVC, animated: true)
            } else {
                print("NextViewController를 인스턴스화할 수 없습니다.")
            }
                    }
        //입력된 id 정보가 가입 안되어있을 경우 안내 알럿
        else {
            showAlert(message: "ID 또는 Password가 일치하지 않습니다.")
        }
  
    }

    
    //알럿
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //회원가입페이지로 이동
    @IBAction func createAccountButton(_ sender: Any) {
        guard let SignupVC = self.storyboard?.instantiateViewController(identifier: "SignupVC") else {return}
        //self.present(SignupVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(SignupVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupidTF()
        setuppwTF()
    }


}
