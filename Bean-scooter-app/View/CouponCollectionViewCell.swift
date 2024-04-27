import UIKit

class CouponCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discountRateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var couponModel: CouponModel?

    override func awakeFromNib() {
        super.awakeFromNib()

        // Cell에 탭 제스쳐레컨나이저 적용
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        contentView.addGestureRecognizer(tapGesture)
    }

    func configure(with coupon: CouponModel) {
        self.couponModel = coupon
        imageView.image = UIImage(named: coupon.imageName)
        discountRateLabel.text = coupon.discountRate
        dateLabel.text = coupon.dateLabel
    }

    @objc func handleTapGesture() {
        guard let coupon = couponModel else { return }

        // Delegate (CouponViewController)에게 쿠폰이 탭 됨을 알림
        NotificationCenter.default.post(name: Notification.Name("CouponTapped"), object: nil, userInfo: ["coupon": coupon])
    }
}
