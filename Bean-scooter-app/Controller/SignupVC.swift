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
    
    //All textfield set up
    func setupAllTF() {
        nameTextField.placeholder = "닉네임을 입력하세요"
        nameTextField.backgroundColor = .systemGray5
        nameTextField.keyboardType = UIKeyboardType.emailAddress
        nameTextField.clearButtonMode = .always
        nameTextField.becomeFirstResponder()
        
        idTextField.placeholder = "ID를 입력하세요"
        idTextField.backgroundColor = .systemGray5
        idTextField.keyboardType = UIKeyboardType.emailAddress
        idTextField.clearButtonMode = .always
        
        passwordTextField.placeholder = "비밀번호를 입력하세요"
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.clearButtonMode = .always
        passwordTextField.isSecureTextEntry = true //텍스트보안
    }
    
    
    //Buttons
    
    var isAgreed = false
    
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
        
        // 이름 중복 방지
        if accauntInfoArr.contains(where: { $0.userName == name }) {
            showAlert(message: "'\(name)'은 이미 사용중인 이름입니다.")
            return
        }
        // id 중복 방지
        if accauntInfoArr.contains(where: { $0.iD == id }) {
            showAlert(message: "'\(id)'은 이미 사용중인 id입니다.")
            return
        }
        
        // 계정 정보를 배열에 추가
        let newAccount = AccauntInfo(iD: id, passWord: password, userName: name)
        accauntInfoArr.append(newAccount)
        
        let alert = UIAlertController(title: "알림", message: "회원가입이 완료되었습니다. 자동으로 로그인됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인했습니다", style: .default) { _ in
            if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "nextVC") as? NextViewController {
                nextVC.myid = id
                nextVC.myname = name
                //self.present(nextVC, animated: true, completion: nil)
                self.navigationController?.pushViewController(nextVC, animated: true)
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
    
    
    
//    func addAccountToUserDefaults(account: AccauntInfo) {
//        // 이전에 저장된 배열이 있는지 확인
//        if let data = UserDefaults.standard.data(forKey: "accauntInfoArr"),
//           var savedAccounts = try? JSONDecoder().decode([AccauntInfo].self, from: data) {
//            // 이전에 저장된 배열이 있는 경우, 새 계정 추가
//            savedAccounts.append(account)
//            // 새로운 배열을 유저 디폴트에 다시 저장
//            if let newData = try? JSONEncoder().encode(savedAccounts) {
//                UserDefaults.standard.set(newData, forKey: "accauntInfoArr")
//            }
//        } else {
//            // 이전에 저장된 배열이 없는 경우, 새 배열 생성 후 계정 추가
//            let newArray = [account]
//            if let newData = try? JSONEncoder().encode(newArray) {
//                UserDefaults.standard.set(newData, forKey: "accauntInfoArr")
//            }
//        }
//    }
//
//    
//    // 3. 앱 시작 시 유저 디폴트에서 accauntInfoArr 불러오기
//    func loadAccountsFromUserDefaults() -> [AccauntInfo] {
//        if let data = UserDefaults.standard.data(forKey: "accauntInfoArr"),
//           let savedAccounts = try? JSONDecoder().decode([AccauntInfo].self, from: data) {
//            return savedAccounts
//        } else {
//            return []
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAllTF()
        //accauntInfoArr = loadAccountsFromUserDefaults()
    }
    
    
    
}
