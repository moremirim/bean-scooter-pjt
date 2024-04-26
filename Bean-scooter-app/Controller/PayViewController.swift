//
//  PayViewController.swift
//  Bean-scooter-app
//
//  Created by 박미림 on 4/25/24.
//

import UIKit

class PayViewController: UIViewController {
    
    @IBOutlet weak var applePay: UIView!
    @IBOutlet weak var payPal: UIView!
    @IBOutlet weak var mastercard: UIView!
    @IBOutlet weak var samsungPay: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var payNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let chosen1 = UITapGestureRecognizer(target: self, action: #selector(tapApplePay))
        let chosen2 = UITapGestureRecognizer(target: self, action: #selector(tapPayPal))
        let chosen3 = UITapGestureRecognizer(target: self, action: #selector(tapMastercard))
        let chosen4 = UITapGestureRecognizer(target: self, action: #selector(tapSamsungPay))
        
        applePay.addGestureRecognizer(chosen1)
        payPal.addGestureRecognizer(chosen2)
        mastercard.addGestureRecognizer(chosen3)
        samsungPay.addGestureRecognizer(chosen4)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var totalDistance = RecordSingleton.shared.array.map{ $0.distance }.reduce(0, +)
        distanceLabel.text = "\(totalDistance) m"
        priceLabel.text = "\(Int(Double(totalDistance) * 1.8)) 원"
    }
    
    @objc func tapApplePay() {
        applePay.layer.borderWidth = 2
        payPal.layer.borderWidth = 0.5
        mastercard.layer.borderWidth = 0.5
        samsungPay.layer.borderWidth = 0.5
    }
    
    @objc func tapPayPal() {
        applePay.layer.borderWidth = 0.5
        payPal.layer.borderWidth = 2
        mastercard.layer.borderWidth = 0.5
        samsungPay.layer.borderWidth = 0.5
    }
    
    @objc func tapMastercard() {
        applePay.layer.borderWidth = 0.5
        payPal.layer.borderWidth = 0.5
        mastercard.layer.borderWidth = 2
        samsungPay.layer.borderWidth = 0.5
    }
    
    @objc func tapSamsungPay() {
        applePay.layer.borderWidth = 0.5
        payPal.layer.borderWidth = 0.5
        mastercard.layer.borderWidth = 0.5
        samsungPay.layer.borderWidth = 2
    }
    
    @IBAction func didTapPayNowButton(_ sender: Any) {
        
        let paymentAlert = UIAlertController(title: "결제 확인", message: "결제가 진행됩니다", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "결제", style: .default) { _ in
            let confirmationAlert = UIAlertController(title: "결제 완료", message: "결제가 정상 처리 되었습니다", preferredStyle: .alert)
            let checkAction = UIAlertAction(title: "확인", style: .default)
            confirmationAlert.addAction(checkAction)
            self.present(confirmationAlert, animated: true)
            self.applePay.layer.borderWidth = 0.5
            self.payPal.layer.borderWidth = 0.5
            self.mastercard.layer.borderWidth = 0.5
            self.samsungPay.layer.borderWidth = 0.5
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    
        paymentAlert.addAction(cancelAction)
        paymentAlert.addAction(okAction)
        present(paymentAlert, animated: true)
    }
    

}

extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
}

