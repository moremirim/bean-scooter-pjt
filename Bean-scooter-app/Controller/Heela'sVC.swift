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
        guard let id = idTextField.text else {
            showAlert(message: "ID를 입력하세요.")
            return
        }
        
        //입력된 id가 회원가입되어있을 경우,
        if accauntInfoArr.contains(where: { $0.iD == id }) {
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "nextVC") else {return}
            self.present(nextVC, animated: true, completion: nil)
        }
        //입력된 id 정보가 가입 안되어있을 경우,
        else {
            showAlert(message: "가입되지 않은 ID입니다.")
        }
        
        // 필드에 담긴 정보가 회원 배열에 있을경우, 마이페이지로 보내고 다음화면으로 이동, 없을경우 안내 알럿
        
    }//button
    
    
    //알럿
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }//알럿
    
    
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        // 회원가입페이지로 이동
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupidTF()
        setuppwTF()
    }


}
