import UIKit

class GameSetupViewController: FormViewController {

    private lazy var titleLabel = buildTitleLabel()
    private lazy var nameTextField = buildTextField()
    private lazy var continueButton = buildContinueButton()
    private lazy var stackView = makeStackView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        styleNavigationBar()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.removePreviousViewControllers()
        configureContainerView()
    }

    private func configureContainerView() {
        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40)
        ])
    }

    @objc private func onContinueTap() {
        GameSession.shared.playerName = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        let vc = GameTableViewController(style: .plain)
        vc.viewModel = GameTableViewModel(delegate: vc, songs: MediaPlayerController.shared.randomSongsFromUniqueArtists)
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - UITextFieldDelegate

extension GameSetupViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        continueButton.buttonState = nameTextField.hasText ? .normal : .disable
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

// MARK: - UI factory

private extension GameSetupViewController {

    private func buildTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "configureGame".localized()
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func buildTextField() -> OmniTextField {
        let textField = OmniTextField()
        textField.placeholder = "yourName".localized()
        textField.textContentType = .name
        textField.autocapitalizationType = .words
        textField.delegate = self
        return textField
    }

    private func buildContinueButton() -> PrimaryButton {
        let button = PrimaryButton(state: .disable)
        button.setTitle("playAction".localized(), for: .normal)
        button.addTarget(self, action: #selector(onContinueTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return button
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(continueButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

}
