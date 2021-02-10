import UIKit

extension UIViewController {

    func styleNavigationBar() {
        navigationItem.standardAppearance = UINavigationBarAppearance()
        navigationItem.standardAppearance?.backgroundColor = .systemBackground
        navigationItem.standardAppearance?.shadowColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.primary
    }

}
