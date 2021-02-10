import UIKit
import MediaPlayer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        guard !Token.appleMusic.isEmpty else { fatalError("Configure your Apple Music token in the Token struct") }
        guard !Token.musixmatch.isEmpty else { fatalError("Configure your Musixmatch API key in the Token struct") }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: getRootViewController())
        self.window = window
        window.makeKeyAndVisible()
    }

    private func getRootViewController() -> UIViewController {
        switch MPMediaLibrary.authorizationStatus() {
        case .authorized: // The user has previously granted access to the media library.
            if MediaPlayerController.shared.hasMinimumAmountOfArtistsToPlay() {
                return GameSetupViewController()
            } else {
                return NotEnoughArtistsViewController()
            }
        case .notDetermined: // The user has not yet been asked for media library access.
            return RequestAuthorizationViewController()
        case .denied: // The user has previously denied access.
            return NotAuthorizedViewController()
        case .restricted: // The user can't grant access due to restrictions.
            return NotAuthorizedViewController()
        @unknown default:
            return NotAuthorizedViewController()
        }
    }

}
