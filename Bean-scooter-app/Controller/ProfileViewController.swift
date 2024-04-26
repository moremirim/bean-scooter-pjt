
// 나연의 프로필 뷰

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myImage: UIImageView!
    
    func setupmyImage() {
        if let currentUser = AccountModel.accountModel.accountInfoArr.first(where: { $0.userName == myName }),
           let imageData = currentUser.profileImage,
           let profileImage = UIImage(data: imageData) {
            print("가져옴", profileImage)
            myImage.image = profileImage
        } else {
            myImage.image = UIImage(named: "profile")
        }
        
        myImage.layer.cornerRadius = myImage.frame.height/2
        myImage.layer.borderWidth = 1
        myImage.clipsToBounds = true
        myImage.layer.borderColor = UIColor.clear.cgColor
    }
    
    //로그인 된 아이디 정보 레이블에 반영
    @IBOutlet weak var myname: UILabel!
    @IBOutlet weak var myID: UILabel!
    
    var myName = ""
    var myId = ""
    
    func setuplabel() {
        let mainColor = UIColor(red: 0x75 / 255.0, green: 0xCE / 255.0, blue: 0xE9 / 255.0, alpha: 1.0)
        myname.text = myName
        myname.textColor = .black
        myID.text = myId
        myID.textColor = mainColor
    }
    
    //수정하기로 이동하는 버튼
    @IBAction func editButton(_ sender: Any) {
        guard let editProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileViewController else { return }
        editProfileVC.myName = self.myName
        editProfileVC.myID = self.myId
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setuplabel()

        setupmyImage()

        
        table.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileList")
        
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .singleLine
        table.rowHeight = 85
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // 더미 데이터
    let dummyData: [ProfileModel] = [
        ProfileModel(iconName: "icon1", title: "Driving Record"),
        ProfileModel(iconName: "iconkick", title: "Driving Guide"),
        ProfileModel(iconName: "icon3", title: "Friend Recommendation"),
        ProfileModel(iconName: "icon4", title: "My Coupon"),
        ProfileModel(iconName: "icon5", title: "Log Out")
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileList", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell ()
            
        }
        
        let item = dummyData[indexPath.row]
        
        cell.iconImageView.image = UIImage(named: item.iconName)
        cell.titleLabel.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
            // 첫 번째 셀(Driving Record : 주행 기록) 선택된 경우
            case 0:
            guard let recordVC = self.storyboard?.instantiateViewController(withIdentifier: "recordVC") as? RecordTableViewController else { return }
            
            self.navigationController?.pushViewController(recordVC, animated: true)
            
            // 두 번째 셀(Driving Guide : 주행 가이드) 선택된 경우
        case 1:
            guard let guideVC = self.storyboard?.instantiateViewController(withIdentifier: "guideVC") as? GuideViewController else {
                return
            }
            self.navigationController?.pushViewController(guideVC, animated: true)
            
            // 세 번째 셀(Friend Recommendation : 친구 추천) 선택된 경우
            //        case 3:
            //            guard let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "signinVC") as? SignInViewController else {
            //                return
            //            }
            //            self.navigationController?.pushViewController(signinVC, animated: true)
            //
            
        case 3:
            guard let couponVC = self.storyboard?.instantiateViewController(withIdentifier: "couponVC") as? CouponViewController else {
                return
            }
            self.navigationController?.pushViewController(couponVC, animated: true)
            
            
            // 다섯 번째 셀(logOut) 선택된 경우
        case 4:
            
            guard let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "signinVC") as? SignInViewController else {
                return
            }
            self.navigationController?.pushViewController(signinVC, animated: true)
            
            
            
        default:
            break
            
            
            
        }
        
        
        
        
        
    }
}



