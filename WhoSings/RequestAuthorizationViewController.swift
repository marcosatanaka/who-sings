import UIKit
import MediaPlayer

class RequestAuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        styleNavigationBar()
        requestMediaLibraryAccess()
    }

    private func requestMediaLibraryAccess() {
        MPMediaLibrary.requestAuthorization { authorizationStatus in
            DispatchQueue.main.async {
                if authorizationStatus == .authorized {
                    if MediaPlayerController.shared.hasMinimumAmountOfArtistsToPlay() {
                        self.navigationController?.pushViewController(GameSetupViewController(), animated: false)
                    } else {
                        self.navigationController?.pushViewController(NotEnoughArtistsViewController(), animated: false)
                    }
                } else {
                    self.navigationController?.pushViewController(NotAuthorizedViewController(), animated: false)
                }
            }
        }
    }

}
