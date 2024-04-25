
// 나연의 프로필 뷰

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
            
        // 첫 번째 셀(Driving Record : 주행 기록) 선택된 경우
        //case 0:
        
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


