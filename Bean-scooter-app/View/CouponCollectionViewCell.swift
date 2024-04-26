import UIKit

class CouponCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discountRateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var couponModel: CouponModel?

    override func awakeFromNib() {
        super.awakeFromNib()

        // Add tap gesture recognizer to the cell
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
        // Notify the delegate (CouponViewController) that a coupon was tapped
        NotificationCenter.default.post(name: Notification.Name("CouponTapped"), object: nil, userInfo: ["coupon": coupon])
    }
}
