import UIKit

class PrimaryButton: UIButton {

    var buttonState: PrimaryButtonState {
        didSet {
            let pressedColor = buttonState.backgroundColor()?.lighter(by: 30) ?? .clear
            setBackgroundImage(UIImage(color: pressedColor), for: .highlighted)
            backgroundColor = buttonState.backgroundColor()
            setTitleColor(buttonState.textColor(), for: .normal)
            setTitleColor(buttonState.textColor(), for: .highlighted)

            switch buttonState {
            case .disable:
                isEnabled = false
            default:
                isEnabled = true
            }
        }
    }

    init(state: PrimaryButtonState) {
        self.buttonState = state
        super.init(frame: CGRect())
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.buttonState = { buttonState }()
        clipsToBounds = true
        layer.cornerRadius = 12
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout).bold()
    }

}

// MARK: - PrimaryButtonState

enum PrimaryButtonState {
    case normal
    case disable

    func backgroundColor() -> UIColor? {
        switch self {
        case .normal:
            return UIColor.primary
        case .disable:
            return UIColor.primary.withAlphaComponent(0.1)
        }
    }

    func textColor() -> UIColor? {
        switch self {
        case .normal:
            return UIColor.white
        case .disable:
            return UIColor.primary.lighter(by: 40)
        }
    }
}
