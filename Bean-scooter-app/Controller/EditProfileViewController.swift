//
//  EditProfile.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/25/24.
//

import UIKit
import PhotosUI


class EditProfileViewController: UIViewController {
    
    // MARK: - 피커뷰(트리거:버튼)
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var editProfileImageButton: UIButton!
    
    func setupEditButton() {
        editProfileImageButton.addTarget(self, action: #selector(editProfileImage), for: .touchUpInside)
    }
    
    @objc func editProfileImage() {
        present(imagePicker, animated: true, completion: nil) // 이미지 피커를 엽니다.
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - 프로필이미지
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    func setupImageView() {
        if let currentUser = AccountModel.accountModel.accountInfoArr.first(where: { $0.userName == myName }),
               let imageData = currentUser.profileImage,
               let profileImage = UIImage(data: imageData) {
            print("가져옴2", profileImage)
                profileImageView.image = profileImage
            } else {
                // 저장된 이미지가 없거나 올바르게 불러와지지 않은 경우 기본 이미지를 설정합니다.
                profileImageView.image = UIImage(named: "profile")
            }
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    // MARK: - 상단 프로필네임, 아이디
    
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
    
    // MARK: - 텍스트필드
    
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

    // MARK: - 수정/삭제 버튼
    
    
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var delete: UIButton!
    
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
            guard let signinVC = self.storyboard?.instantiateViewController(identifier: "SigninVC") else {return}
            self.navigationController?.pushViewController(signinVC, animated: true)
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
                guard let signinVC = self.storyboard?.instantiateViewController(identifier: "SigninVC") else {return}
                self.navigationController?.pushViewController(signinVC, animated: true)
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
    
    func setupButton() {
        let mainColor = UIColor(red: 0x75 / 255.0, green: 0xCE / 255.0, blue: 0xE9 / 255.0, alpha: 1.0)
        submit.setTitle("SUBMIT", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        
        delete.setTitle("Delete Account", for: .normal)
        delete.setTitleColor(.white, for: .normal)
    }
    
// MARK: - 알럿
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

        setupImageView()
        setupEditButton()
        setupButton()
        
        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
        self.imagePicker.allowsEditing = true // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
        self.navigationController?.isNavigationBarHidden = false

    }
    
}



extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        // 선택된 이미지를 UserDefaults에 저장
        self.profileImageView.image = newImage // 받아온 이미지를 update
        if let imageData = newImage?.jpegData(compressionQuality: 1.0),
           let index = AccountModel.accountModel.accountInfoArr.firstIndex(where: { $0.userName == self.myName }) {
            AccountModel.accountModel.accountInfoArr[index].profileImage = imageData
        }
        
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
}
