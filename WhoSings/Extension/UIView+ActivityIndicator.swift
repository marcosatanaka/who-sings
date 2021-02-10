import UIKit

extension UIView {

    func showActivityIndicator(backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.2)) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647

        let activityIndicatorBorder = UIView()
        activityIndicatorBorder.backgroundColor = UIColor.lightGray
        activityIndicatorBorder.roundCorners(radius: 12)
        activityIndicatorBorder.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorBorder.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicatorBorder.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        isUserInteractionEnabled = false
        backgroundView.addSubview(activityIndicatorBorder)
        activityIndicatorBorder.addSubview(activityIndicator)
        addSubview(backgroundView)

        NSLayoutConstraint.activate([
            activityIndicatorBorder.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicatorBorder.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorBorder.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorBorder.centerYAnchor),
        ])
    }

    func hideActivityIndicator() {
        if let background = viewWithTag(475647) {
            background.removeFromSuperview()
        }
        isUserInteractionEnabled = true
    }

}
