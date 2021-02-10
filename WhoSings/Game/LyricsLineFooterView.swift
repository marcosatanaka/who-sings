import UIKit

class LyricsLineFooterView: UIView {

    lazy var copyrightLabel = createCopyrightLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .systemBackground
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(copyrightLabel)

        NSLayoutConstraint.activate([
            copyrightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            copyrightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            copyrightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            copyrightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28)
        ])
    }

}

// MARK: - UI factory

private extension LyricsLineFooterView {

    private func createCopyrightLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textColor = UIColor.tertiaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
