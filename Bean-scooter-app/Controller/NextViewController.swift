//
//  NextViewController.swift
//  Bean-scooter-app
//
//  Created by t2023-m0114 on 4/23/24.
//

import Foundation
import UIKit


class NextViewController: UIViewController {
    
    @IBOutlet weak var idL: UILabel!
    
    @IBOutlet weak var pwL: UILabel!
    
    @IBOutlet weak var nameL: UILabel!
    
    
    var myid: String?
    var mypw: String?
    var myname: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = myid {
            idL.text = "ID: \(id)"
        }
        if let pw = mypw {
            pwL.text = "Password: \(pw)"
        }
        if let name = myname {
            nameL.text = "Name: \(name)"
        }
    }
}
