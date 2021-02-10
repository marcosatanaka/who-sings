import UIKit

public extension UIView {

    func roundCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func roundTopCorners(radius: CGFloat) {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

    func roundBottomCorners(radius: CGFloat) {
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }

}
