//
//  ModalViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/25/24.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: - 시리얼 넘버
    lazy var serialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    
    // MARK: - 주소
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 배터리
    lazy var batteryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - 이미지
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "kic")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        serialLabel.text = "기기번호: 1245512"
        //addressLabel.text = "주소: 서울특별시 종로구 효자로 12"
        batteryLabel.text = "배터리 잔량: 100%"
        
        applyConstraints()
    }
    
    func applyConstraints () {
        view.addSubview(serialLabel)
        view.addSubview(batteryLabel)
        view.addSubview(addressLabel)
        view.addSubview(imageView)

        let serialLabelConstraints = [
            serialLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            serialLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let batteryLabelConstraints = [
            batteryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            batteryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let addressLabelConstraints = [
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            addressLabel.topAnchor.constraint(equalTo: serialLabel.bottomAnchor, constant: 10)
        ]
        
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.topAnchor.constraint(equalTo: serialLabel.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(serialLabelConstraints)
        NSLayoutConstraint.activate(batteryLabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)

    }

}
