//
//  ScooterManageViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import UIKit

class ScooterManageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ScooterManageTableViewCell", bundle: nil), forCellReuseIdentifier: "manageCell")
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }

    @IBAction func addPinData(_ sender: UIButton) {
        var serialNumber: String = ""
        var x: Double = 0.0
        var y: Double = 0.0
        
        let alert = UIAlertController(title: "킥보드를 추가합니다.", message: "아래에 정보를 입력해주세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "10자리의 Code를 입력해주세요"
        }
        alert.addTextField { textField in
            textField.placeholder = "경도: ex) -122.030189"
        }
        alert.addTextField { textField in
            textField.placeholder = "위도: ex) 37.331676"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            serialNumber = alert.textFields?[0].text ?? "코드입력을 다시 해주세요."
            x = Double(alert.textFields?[1].text ?? "0.0")!
            y = Double(alert.textFields?[2].text ?? "0.0")!
            
            PinSingleton.shared.array.append(PinModel(x: x, y: y, id: serialNumber))
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension ScooterManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PinSingleton.shared.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "manageCell", for: indexPath) as? ScooterManageTableViewCell else {
            return UITableViewCell() }
        
        cell.serialLabel.text = "\(indexPath.row + 1)호기 Serial Number: \(PinSingleton.shared.array[indexPath.row].id)"
        cell.delteBtn.tag = indexPath.row
        cell.delteBtn.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        
        return cell
    }
    
    @objc func deleteEvent(sender: UIButton) {
        
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: "삭제를 하시면 등록된 킥보드 정보가 삭제가 됩니다.\n해당 정보는 되돌릴 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
            PinSingleton.shared.array.remove(at: sender.tag)
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true)
    }
    
}
