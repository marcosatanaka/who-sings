import UIKit

class NotEnoughArtistsViewController: UIViewController {

    private lazy var titleLabel = buildTitleLabel()
    private lazy var subtitleLabel = buildSubtitleLabel()
    private lazy var tryAgainButton = buildTryAgainButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        styleNavigationBar()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.removePreviousViewControllers()
        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tryAgainButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -112),

            subtitleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),

            tryAgainButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            tryAgainButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            tryAgainButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28)
        ])
    }

    @objc private func onTryAgainTap() {
        if MediaPlayerController.shared.hasMinimumAmountOfArtistsToPlay() {
            self.navigationController?.pushViewController(GameSetupViewController(), animated: true)
        } else {
            self.navigationController?.pushViewController(NotEnoughArtistsViewController(), animated: true)
        }
    }

}

// MARK: - UI factory

private extension NotEnoughArtistsViewController {

    private func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = GameSession.shared.playerName
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.text = "notEnoughArtistsTitle".localized()
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
        label.text = "notEnoughArtistsMessage".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func buildTryAgainButton() -> UIButton {
        let button = UIButton()
        button.setTitle("tryAgainAction".localized(), for: .normal)
        button.setTitleColor(UIColor.primary, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout).bold()
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onTryAgainTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

}
