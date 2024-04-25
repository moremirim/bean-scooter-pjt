
// 나연의 프로필 뷰

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileList")
        
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.rowHeight = 85
    }
    
    
    // 더미 데이터
    let dummyData: [ProfileModel] = [
        ProfileModel(iconName: "Icone01", title: "Driving Record"),
        ProfileModel(iconName: "image02", title: "Driving Guide"),
        ProfileModel(iconName: "icon3", title: "Friend Recommendation"),
        ProfileModel(iconName: "Icon04", title: "My Coupon"),
        ProfileModel(iconName: "image05", title: "Log Out")
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileList", for: indexPath) as! ProfileTableViewCell
        let item = dummyData[indexPath.row]
        
        //  cell.iconImageView.image = UIImage(systemName: "scooter")
        cell.iconImageView.image = UIImage(named: item.iconName)
        cell.titleLabel.text = item.title
        //  cell.selectionStyle = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 다음 화면으로 전환하는 코드
        let nextVC = SignupVC()
    //    nextVC.selectedItem = String[indexPath.row]
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    class SignupVC: UIViewController, UITextFieldDelegate {
        
        var selectedItem: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if let selectedItem = selectedItem {
                
      //          print(indexPath.row)
            }
        }
    }
    
}








