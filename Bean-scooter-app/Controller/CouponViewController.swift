//
//  CouponViewController.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/26/24.
//

import UIKit

class CouponViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    let couponDummyData: [CouponModel] = [
        CouponModel(imageName: "icon007", discountRate: "80%", dateLabel: "Valid until December 1st, 2024"),
        CouponModel(imageName: "icon007", discountRate: "50%", dateLabel: "Valid until June 1st, 2024"),
        CouponModel(imageName: "icon007", discountRate: "10%", dateLabel: "Valid until May 1st, 2024")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell class
        collectionView.register(UINib(nibName: "CouponCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CouponCollectionViewCell")
        
        // Set collection view delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Observe coupon tapped notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleCouponTapped(_:)), name: Notification.Name("CouponTapped"), object: nil)
    }
    deinit {
        // Remove observer when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleCouponTapped(_ notification: Notification) {
        guard let coupon = notification.userInfo?["coupon"] as? CouponModel else { return }
        
        // Show alert when coupon is tapped
        let alert = UIAlertController(title: "Coupon Applied", message: "Coupon \(coupon.discountRate) has been applied!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        

        
    }
}

extension CouponViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return couponDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCollectionViewCell", for: indexPath) as! CouponCollectionViewCell
        
        // Configure cell with data
        let item = couponDummyData[indexPath.item]
        cell.configure(with: item) // Implement a configure method in CouponCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Return the size of your collection view cell
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}


