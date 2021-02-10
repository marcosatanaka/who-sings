import UIKit

extension UINavigationController {

    func removePreviousViewControllers() {
        let allControllers = NSMutableArray(array: viewControllers)
        guard allControllers.count > 1 else { return }
        allControllers.removeObject(at: allControllers.count - 2)
        setViewControllers(allControllers as [AnyObject] as! [UIViewController], animated: false)
    }

}
