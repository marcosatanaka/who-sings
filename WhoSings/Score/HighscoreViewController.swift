import UIKit
import os.log

class HighscoreViewController: UIViewController {

    private lazy var scoreLabel = buildScoreLabel()
    private lazy var bestPlayersTableView = buildBestPlayersTableView()
    private lazy var playAgainButton = buildPlayAgainButton()

    private let cellReuseIdentifier = "HighscoreCell"
    private var highscoreList = UserDefaultsPersistence.getHighscoreList()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "yourScore".localized()
        styleNavigationBar()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.removePreviousViewControllers()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onUserProfileTap))
        addSubviews()
    }

    deinit {
        Logger.memory.info("HighscoreViewController was deinitialized")
    }

    private func addSubviews() {
        view.addSubview(scoreLabel)
        view.addSubview(bestPlayersTableView)
        view.addSubview(playAgainButton)

        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 28),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -28),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),

            bestPlayersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bestPlayersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bestPlayersTableView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            bestPlayersTableView.bottomAnchor.constraint(equalTo: playAgainButton.topAnchor, constant: -40),

            playAgainButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 12),
            playAgainButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -12),
            playAgainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }

    @objc private func onUserProfileTap() {
        let vc = ProfileViewController()
        vc.onLogoff = {
            GameSession.shared.currentCard = 1
            GameSession.shared.points = 0
            GameSession.shared.playerName = nil
            self.navigationController?.pushViewController(GameSetupViewController(), animated: true)
        }
        present(UINavigationController(rootViewController: vc), animated: true)
    }

    @objc private func onPlayAgainTap() {
        GameSession.shared.currentCard = 1
        GameSession.shared.points = 0

        let vc = GameTableViewController(style: .plain)
        vc.viewModel = GameTableViewModel(delegate: vc, songs: MediaPlayerController.shared.randomSongsFromUniqueArtists)
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension HighscoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscoreList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highscoreItem = highscoreList[indexPath.row]

        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellReuseIdentifier)
        }

        cell!.textLabel?.text = highscoreItem.playerName
        cell!.detailTextLabel?.text = String(highscoreItem.score)
        cell!.textLabel?.textColor = UIColor.text
        cell!.detailTextLabel?.textColor = UIColor.text
        return cell!
    }

}

// MARK: - UI factory

private extension HighscoreViewController {

    private func buildScoreLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(GameSession.shared.points)
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func buildBestPlayersTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    private func buildPlayAgainButton() -> PrimaryButton {
        let button = PrimaryButton(state: .normal)
        button.setTitle("playAgainAction".localized(), for: .normal)
        button.addTarget(self, action: #selector(onPlayAgainTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return button
    }

}
