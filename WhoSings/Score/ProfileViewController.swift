import UIKit
import os.log

class ProfileViewController: UIViewController {

    private lazy var playerNameLabel = buildPlayerNameLabel()
    private lazy var playerScoresTableView = buildPlayerScoresTableView()

    private let cellReuseIdentifier = "ScoreCell"
    private var playerScoresList = UserDefaultsPersistence.getHighscoreList().filter { $0.playerName == GameSession.shared.playerName }
    var onLogoff: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "profile".localized()
        styleNavigationBar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logoff".localized(),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onLogoffTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(onDoneTap))
        addSubviews()
    }

    deinit {
        Logger.memory.info("ProfileViewController was deinitialized")
    }

    private func addSubviews() {
        view.addSubview(playerNameLabel)
        view.addSubview(playerScoresTableView)

        NSLayoutConstraint.activate([
            playerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            playerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            playerNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),

            playerScoresTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerScoresTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerScoresTableView.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 40),
            playerScoresTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func onDoneTap() {
        dismiss(animated: true)
    }

    @objc private func onLogoffTap() {
        dismiss(animated: true) {
            self.onLogoff?()
        }
    }

}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerScoresList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let highscoreItem = playerScoresList[indexPath.row]

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

private extension ProfileViewController {

    private func buildPlayerNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = GameSession.shared.playerName
        label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
        label.textColor = UIColor.text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func buildPlayerScoresTableView() -> UITableView {
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

}
