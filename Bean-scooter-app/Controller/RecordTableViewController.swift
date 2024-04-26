//
//  RecordTableViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/26/24.
//

import UIKit

class RecordTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
  
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")

        self.navigationController?.isNavigationBarHidden = false

    }



}

extension RecordTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RecordSingleton.shared.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordTableViewCell else {
            return UITableViewCell() }
        
        let time =  RecordSingleton.shared.array[indexPath.row].time
        let distance = RecordSingleton.shared.array[indexPath.row].distance
        let price = Int(Double(distance) * 1.8)
        
        cell.dateLabel.text = "날짜: \(time)m"
        cell.distanceLabel.text = "주행거리: \(distance)"
        cell.priceLabel.text = "금액: \(price)원"
        
        return cell
    }

    
}
