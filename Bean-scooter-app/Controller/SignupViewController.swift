//
//  SignupVC.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/23/24.
//

import UIKit


class SignupVC: UIViewController, UITextFieldDelegate {

    //Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    
    //Textfields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //셋업 :
    func setupAllTF() {
        nameTextField.placeholder = " 3~8글자 문자의 닉네임을 입력하세요 "
        nameTextField.backgroundColor = .systemGray5
        nameTextField.keyboardType = UIKeyboardType.emailAddress
        nameTextField.clearButtonMode = .always
        nameTextField.becomeFirstResponder()
        nameTextField.layer.cornerRadius = 5
        
        idTextField.placeholder = " ID를 입력하세요"
        idTextField.backgroundColor = .systemGray5
        idTextField.keyboardType = UIKeyboardType.emailAddress
        idTextField.clearButtonMode = .always
        idTextField.layer.cornerRadius = 5
        
        passwordTextField.placeholder = " 비밀번호를 입력하세요"
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.clearButtonMode = .always
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true //텍스트보안
    }
    //키보드 로직 :
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //리턴 버튼을 누를때 다름 텍스트필드로 이동.
        if textField == nameTextField {
            // 글자 수 제한 (최소 3글자, 최대 8글자)
            if let text = nameTextField.text, text.count < 3 || text.count > 8 {
                showAlertAndClearText()
                return false
            }
            idTextField.becomeFirstResponder()
        } else if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder() // 키보드 종료.
        }
        return false
    }
    //알렛 : name 텍스트필드 글자수제한 오류
    func showAlertAndClearText() {
        let alert = UIAlertController(title: "입력 오류", message: "닉네임은 최소 3글자, 최대 8글자로 입력해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.nameTextField.text = ""
        }))
        present(alert, animated: true, completion: nil)
    }
    // UITextFieldDelegate 프로토콜 메서드 :
    // nameTextField 에는 숫자를 입력할 수 없음.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
        }
        return true
    }
    
    
    
    //Buttons
    
    //동의 버튼
    //액션 : 누르면 isAgreed 상태 변경 및 setImage 변경.
    var isAgreed = false//로그인버튼에서 동의 상태값을 판단할 수 있는 변수
    
    @IBAction func agreeButton(_ sender: UIButton) {
        isAgreed = !isAgreed
        
        if isAgreed {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            sender.setTitleColor(.blue, for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            sender.setTitleColor(.gray, for: .normal)
        }
    }
    
    
    //로그인 버튼
    //셋업 : 타이틀 및 컬러 지정
    @IBOutlet weak var logInBT: UIButton!
    func setuplogInBT() {
        let mainColor = UIColor(red: 0x75 / 255.0, green: 0xCE / 255.0, blue: 0xE9 / 255.0, alpha: 1.0)
        logInBT.setTitle("Create account & Log in", for: .normal)
        logInBT.setTitleColor(.white, for: .normal)
        logInBT.backgroundColor = mainColor
    }
    //액션 :
    @IBAction func logInButton(_ sender: UIButton) {
        // adreeButton이 선택되지 않았을 경우에만 로그인 처리를 진행
        if !isAgreed {
            showAlert(message: "이용 약관에 동의해주세요.")
            return
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
              let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // 하나 이상의 필드가 비어 있으면 알림 표시
            showAlert(message: "모든 필드에 내용을 입력하세요.")
            return
        }

        // 이름,id 중복 방지
        if AccountModel.accountModel.accountInfoArr.contains(where: { $0.userName == name }) {
            showAlert(message: "'\(name)'은 이미 사용중인 이름입니다.")
            return
        }
        if AccountModel.accountModel.accountInfoArr.contains(where: { $0.iD == id }) {
            showAlert(message: "'\(id)'은 이미 사용중인 id입니다.")
            return
        }
        
        // 계정 정보를 배열에 추가
        let newAccount = AccountInfo(iD: id, passWord: password, userName: name)
        AccountModel.accountModel.addAccount(newAccount: newAccount) //새로운 계정 정보가 유저디폴트에 저장
        
        let alert = UIAlertController(title: "알림", message: "회원가입이 완료되었습니다. 자동으로 로그인됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인했습니다", style: .default) { _ in
            if let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "tapVC") as? TabbarViewController {

                self.navigationController?.pushViewController(tabVC, animated: true)
            } else {
                print("NextViewController를 인스턴스화할 수 없습니다.")
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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

        setupAllTF()
        setuplogInBT()
        nameTextField.delegate = self
    }
    
    
    
//        if let selectedItem = selectedItem {
//            print(selectedItem) // 선택된 행의 데이터 출력
//            print(indexPath.row) // 선택된 행의 인덱스 출력
//        }

    
    
}
