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

        self.navigationController?.isNavigationBarHidden = false
        

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "recordCell")


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
        
        cell.dateLabel.text = " \(time)"
        cell.distanceLabel.text = " \(distance) m"
        cell.priceLabel.text = " \(price)원"
        
        return cell
    }

    
}
