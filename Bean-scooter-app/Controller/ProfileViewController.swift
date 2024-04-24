
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
        ProfileModel(iconName: "image01", title: "주행 기록"),
        ProfileModel(iconName: "image02", title: "주행 가이드"),
        ProfileModel(iconName: "image03", title: "친구 추천"),
        ProfileModel(iconName: "image04", title: "나의 쿠폰"),
        ProfileModel(iconName: "image05", title: "로그 아웃")
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileList", for: indexPath) as! ProfileTableViewCell
        let item = dummyData[indexPath.row]
        
        cell.iconImageView.image = UIImage(named: item.iconName)
        cell.titleLabel.text = item.title
        
        return cell
    }
}



