//
//  ScooterManageViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import UIKit
import CoreData

class ScooterManageViewController: UIViewController {

    let appDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ScooterManageTableViewCell", bundle: nil), forCellReuseIdentifier: "manageCell")
        tableView.reloadData()
        
        self.navigationController?.isNavigationBarHidden = true
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
            
            let newItem = PinData(context: self.context)
            newItem.id = serialNumber
            newItem.x = x
            newItem.y = y
            SavedPinSingleton.shared.array.append(newItem)
            
            do {
                try self.context.save()
            } catch {
                let alert = UIAlertController(title: "에러 발생", message: "데이터 추가 중 오류가 발생했습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
            
            self.tableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension ScooterManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SavedPinSingleton.shared.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "manageCell", for: indexPath) as? ScooterManageTableViewCell else {
            return UITableViewCell() }
        
        cell.serialLabel.text = "\(indexPath.row + 1)호기 Serial Number: \(SavedPinSingleton.shared.array[indexPath.row].id ?? "1A2B3C4D5E")"
        cell.delteBtn.tag = indexPath.row
        cell.delteBtn.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func deleteEvent(sender: UIButton) {
        
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: "삭제를 하시면 등록된 킥보드 정보가 삭제가 됩니다.\n해당 정보는 되돌릴 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { _ in
            self.context.delete(SavedPinSingleton.shared.array[sender.tag])
            SavedPinSingleton.shared.array.remove(at: sender.tag)
            self.appDelegate.saveContext()
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true)
    }
    
}
