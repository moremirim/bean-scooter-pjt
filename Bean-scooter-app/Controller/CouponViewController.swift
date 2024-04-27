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
        CouponModel(imageName: "scooter", discountRate: "80%", dateLabel: "Valid until December 1st, 2024"),
        CouponModel(imageName: "scooter", discountRate: "50%", dateLabel: "Valid until June 1st, 2024"),
        CouponModel(imageName: "scooter", discountRate: "10%", dateLabel: "Valid until May 1st, 2024")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 커스텀 셀 클래스 등록
        collectionView.register(UINib(nibName: "CouponCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CouponCollectionViewCell")
        
        // 쿠폰이 눌렸을 때 처리할 메소드를 등록
        NotificationCenter.default.addObserver(self, selector: #selector(handleCouponTapped(_:)), name: Notification.Name("CouponTapped"), object: nil)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    deinit {
        // 뷰 컨트롤러가 해제될 때 옵저버를 제거
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleCouponTapped(_ notification: Notification) {
        guard let coupon = notification.userInfo?["coupon"] as? CouponModel else { return }
        
        // 쿠폰이 탭 되었을 때 AlertController 표시
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
        
        // 셀을 구성하는 데이터
        let item = couponDummyData[indexPath.item]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 컬렉션 뷰 셀의 사이즈
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}


