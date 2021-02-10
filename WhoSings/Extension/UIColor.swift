import UIKit

extension UIColor {
    static var primary: UIColor {
        UIColor(named: "Primary")!
    }
    static var text: UIColor {
        UIColor(named: "Text")!
    }
}

extension UIColor {

    /**
     Creates a lighter color by changing the RGB values
     */
    func lighterRGB(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustRGB(by: abs(percentage)) ?? self
    }

    /**
     Creates a lighter color by changing the RGB values
     */
    func darkerRGB(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustRGB(by: -1 * abs(percentage)) ?? self
    }

    func adjustRGB(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}

extension UIColor {

    /**
     Creates a lighter color by changing brightness and saturation
     */
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }

    /**
     Creates a darker color by changing brightness and saturation
     */
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }

    /**
     Try to increase brightness or decrease saturation
     */
    private func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }

}
