import UIKit

class OmniTextField: UITextField {

    private lazy var placeholderLabel = buildLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        configureAppearance()
        addSubviews()
        addTarget(self, action: #selector(self.onTextChanged), for: [.editingChanged, .valueChanged])
    }

    private func configureAppearance() {
        layer.borderWidth = 1
        layer.cornerRadius = 12
        font = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontForContentSizeCategory = true

        tintColor = UIColor.gray.lighter(by: 40)
        textColor = UIColor.gray.darker(by: 20)
        backgroundColor = UIColor.systemBackground
        layer.borderColor = UIColor.lightGray.cgColor
        placeholderLabel.textColor = UIColor.gray.lighter(by: 60)
    }

    private func addSubviews() {
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 64),

            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 28),
        ])
    }

    @objc private func onTextChanged() {
        if text != "" {
            placeholderLabel.isHidden = false
            placeholderLabel.text = placeholder
            padding = UIEdgeInsets(top: 0, left: 20, bottom: -22, right: 0)
        } else {
            placeholderLabel.isHidden = true
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
    }

    // MARK: - Padding inset

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

// MARK: - UI factory

private extension OmniTextField {

    private func buildLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

}
