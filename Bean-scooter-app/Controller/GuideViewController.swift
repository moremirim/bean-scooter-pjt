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
        GuideModel(imageName: "image_1", title: "킥스탠드를 접어주세요"),
        GuideModel(imageName: "image_2", title: "앞으로 밀어주세요"),
        GuideModel(imageName: "image_3", title: "시동을 거세요")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideData.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = GuideTable.dequeueReusableCell(withIdentifier: "guideList", for: indexPath) as? GuideTableViewCell else {
            return UITableViewCell ()
        }
        
        
        let content = guideData[indexPath.row]
        
        cell.GuideImage.image = UIImage(named: content.imageName)
        cell.GuideText.text = content.title
        return cell
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



