//
//  ProfileViewController.swift
//  Bean-scooter-app
//
//  Created by 채나연 on 4/22/24.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
       
    }
    
    // array
    
    let array = ["주행 기록","주행 가이드","로그아웃"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
}
