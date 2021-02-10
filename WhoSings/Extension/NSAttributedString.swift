import UIKit

public extension NSAttributedString {

    static func stylizeMonetaryValues(_ string: String, _ font: UIFont, _ color: UIColor) -> NSMutableAttributedString {
        let valueSplit = string.split(separator: " ")
        guard valueSplit.count == 2 else { return NSMutableAttributedString(string: "") }
        return NSMutableAttributedString()
            .normalWith(color: color, font: font, text: "\(String(valueSplit[0])) ")
            .boldWith(color: color, font: font, text: String(valueSplit[1]))
    }

}

public extension NSMutableAttributedString {

    @discardableResult func bold(_ text: String, _ font: UIFont) -> NSMutableAttributedString {
        let boldString = NSMutableAttributedString(string: text, attributes: [.font: font.bold()])
        append(boldString)
        return self
    }

    @discardableResult func normal(_ text: String, _ font: UIFont) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text, attributes: [.font: font])
        append(normal)
        return self
    }

}

public extension NSMutableAttributedString {

    @discardableResult func normalWith(color: UIColor, font: UIFont, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font, .foregroundColor: color])
        append(attributedString)
        return self
    }

    @discardableResult func underlinedWith(color: UIColor, font: UIFont, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font,
                                                                                    .foregroundColor: color,
                                                                                    .underlineStyle: NSUnderlineStyle.single.rawValue])
        append(attributedString)
        return self
    }

    @discardableResult func boldWith(color: UIColor, font: UIFont, text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font.bold(), .foregroundColor: color])
        append(attributedString)
        return self
    }

}

public extension String {

    func strikedThrough() -> NSAttributedString {
        let strikethroughStyle = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        return NSAttributedString(string: self, attributes: strikethroughStyle)
    }

    func underlined() -> NSAttributedString {
        let strikethroughStyle = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        return NSAttributedString(string: self, attributes: strikethroughStyle)
    }

    func regular() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [:])
    }

}
