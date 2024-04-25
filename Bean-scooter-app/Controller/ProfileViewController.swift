
// 나연의 프로필 뷰

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myname: UILabel!
    @IBOutlet weak var myID: UILabel!
    
    var myName = ""
    var myId = ""
    
    func setuplabel() {
        myname.text = myName
        myname.textColor = .black
        myID.text = myId
        myID.textColor = .black
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setuplabel()

        table.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileList")
        
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .singleLine
        table.rowHeight = 85
        
    }
    
    
    // 더미 데이터
    let dummyData: [ProfileModel] = [
        ProfileModel(iconName: "Icon01", title: "Driving Record"),
        ProfileModel(iconName: "iconkick", title: "Driving Guide"),
        ProfileModel(iconName: "icon3", title: "Friend Recommendation"),
        ProfileModel(iconName: "Icon04", title: "My Coupon"),
        ProfileModel(iconName: "logout", title: "Log Out")
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
            //                    case 0:
            //                        // 첫 번째 셀(Driving Record : 주행 기록) 선택된 경우
            //                        let nextVC = DrivingRecord()
            //                        navigationController?.pushViewController(nextVC, animated: true)
        case 4:
            // logOut 셀 선택 시 실행할 코드
            let signupVC = SignupVC(nibName: "SignupViewController", bundle: nil)
            self.navigationController?.pushViewController(signupVC, animated: true)
            
        default:
            break
        }
    }
}


