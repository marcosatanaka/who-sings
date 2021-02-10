import UIKit

class LyricsLineHeaderView: UIView {

    lazy var lyricLabel = createLyricLabel()

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
        addSubview(lyricLabel)

        NSLayoutConstraint.activate([
            lyricLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            lyricLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            lyricLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            lyricLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28)
        ])
    }

}

// MARK: - UI factory

private extension LyricsLineHeaderView {

    private func createLyricLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
