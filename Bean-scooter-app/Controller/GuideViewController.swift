//
//  GuideViewController.swift
//  Bean-scooter-app
//
//  Created by 채나연 on 4/25/24.
//

import UIKit

class GuideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 이용가이드 더미 데이터
    let guideData: [GuideModel] = [
        GuideModel(imageName: "image_1", title: "킥스탠드를 접어주세요", addedLine: "주행 전 킥스탠드를 접어주세요."),
        GuideModel(imageName: "image_2", title: "앞으로 밀어주세요", addedLine: "발로 땅을 밀어 전동킥보드를 움직이세요."),
        GuideModel(imageName: "image_3", title: "시동을 거세요", addedLine: "충분한 추진력이 생기면'주행' 버튼을 부드럽게 길게 누르세요.")
    ]
    
    let safeData: [GuideModel] = [
        GuideModel(imageName: "bean1", title: "헬멧 필수 착용", addedLine: "주행 중에는 반드시 헬멧을 착용해야 합니다."),
        GuideModel(imageName: "bean2", title: "먼저 브레이크를 테스트하세요", addedLine: "브레이크를 작동했을 때 기기가 움직여서는 안됩니다."),
        GuideModel(imageName: "bean3", title: "2인 이상 탑승 금지", addedLine: "라이더 본인 이외의 승객은 절대 함께 탑승할 수 없습니다."),
        GuideModel(imageName: "bean4", title: "음주 운전 금지", addedLine: "약물이나 술을 마신 경우 절대로 주행하지 마세요.")
    ]
    let headers: [String] = ["이용방법", "라이더님과 다른 사람들을 위해 안전하게 주행하세요"]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return guideData.count
            
        } else if section == 1 {
            return safeData.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = GuideTable.dequeueReusableCell(withIdentifier: "guideList", for: indexPath) as? GuideTableViewCell else {
            return UITableViewCell ()
            }
        
        if indexPath.section == 0 {
         
            let content = guideData[indexPath.row]
            
            cell.guideImage.image = UIImage(named: content.imageName)
            cell.guideText.text = content.title
            cell.guideBody.text = content.addedLine
            return cell
        } else if indexPath.section == 1 {
            
            let content = safeData[indexPath.row]
            cell.guideImage.image = UIImage(named: content.imageName)
            cell.guideText.text = content.title
            cell.guideBody.text = content.addedLine
            return cell
        }
        return UITableViewCell ()
        
    }
    
    
    
    
    @IBOutlet weak var GuideTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        GuideTable.register(UINib(nibName: "GuideTableViewCell", bundle: nil), forCellReuseIdentifier: "guideList")
        
        
        GuideTable.dataSource = self
        GuideTable.delegate = self
        GuideTable.separatorStyle = .singleLine
        GuideTable.rowHeight = 100
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
}



