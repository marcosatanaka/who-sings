import UIKit

class NotAuthorizedViewController: UIViewController {

    private lazy var titleLabel = buildTitleLabel()
    private lazy var subtitleLabel = buildSubtitleLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        styleNavigationBar()
        navigationItem.setHidesBackButton(true, animated: false)
        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -112),

            subtitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40)
        ])
    }

}

// MARK: - UI factory

private extension NotAuthorizedViewController {

    private func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = GameSession.shared.playerName
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.text = "mediaLibraryAccessTitle".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func buildSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = GameSession.shared.playerName
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.text = "mediaLibraryAccessMessage".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
