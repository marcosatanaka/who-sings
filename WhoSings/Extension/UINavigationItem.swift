import UIKit

extension UINavigationItem {

    func configureProgressIndicator(currentStep: Int, totalSteps: Int) {
        let progressView = UIProgressView()
        progressView.setProgress(Float(currentStep)/Float(totalSteps), animated: true)
        progressView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        self.titleView = progressView

        let font = UIFont.preferredFont(forTextStyle: .footnote)
        let fontBold = UIFont.preferredFont(forTextStyle: .footnote).bold()
        let color = UIColor.black.lighterRGB(by: 60)
        let progressLabel = UILabel()
        progressLabel.attributedText = NSMutableAttributedString()
            .normalWith(color: color, font: fontBold, text: String(currentStep))
            .normalWith(color: color, font: font, text: "prepositionOf".localized())
            .normalWith(color: color, font: fontBold, text: String(totalSteps))
        self.rightBarButtonItem = UIBarButtonItem(customView: progressLabel)
    }

}
