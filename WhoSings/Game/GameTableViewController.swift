import UIKit
import os.log

class GameTableViewController: UITableViewController {

    private lazy var timerSpacerBarButtonItem = buildSpacerBarButtonItem()
    private lazy var timerLabelBarButtonItem = buildTimerLabelBarButtonItem()

    var viewModel: GameTableViewModel!
    private let cellReuseIdentifier = "ArtistNameCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar()
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.removePreviousViewControllers()
        configureView()

        navigationController?.view.showActivityIndicator()
        viewModel.generateNewQuiz()
    }

    deinit {
        Logger.memory.info("GameTableViewController was deinitialized")
    }

    private func configureView() {
        navigationItem.configureProgressIndicator(currentStep: GameSession.shared.currentCard,
                                                  totalSteps: GameSession.shared.numberOfCards)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }

    private func updateGameSession(didChooseRightArtist: Bool) {
        GameSession.shared.currentCard += 1
        if didChooseRightArtist {
            GameSession.shared.points += 1
        }
        Logger.gameSession.info("\(GameSession.shared)")
    }

    private func goToNextScreen() {
        viewModel.stopTimer()
        navigationController?.setToolbarHidden(true, animated: false)
        if GameSession.shared.gameIsFinished {
            UserDefaultsPersistence.addScore(of: GameSession.shared.points, to: GameSession.shared.playerName ?? "")
            navigationController?.pushViewController(HighscoreViewController(), animated: true)
        } else {
            let vc = GameTableViewController(style: .plain)
            vc.viewModel = GameTableViewModel(delegate: vc, songs: MediaPlayerController.shared.randomSongsFromUniqueArtists)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

// MARK: - Data source

extension GameTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quiz?.artists.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.quiz?.artists[indexPath.row]
        cell.textLabel?.textColor = UIColor.text
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LyricsLineHeaderView()
        headerView.lyricLabel.text = viewModel.quiz?.lyricLine
        return headerView
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = LyricsLineFooterView()
        footerView.copyrightLabel.text = viewModel.quiz?.lyricCopyright
        return footerView
    }

}

// MARK: - Delegate

extension GameTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isRightArtist = viewModel.quiz?.artists[indexPath.row] == viewModel.quiz?.correctArtist
        updateGameSession(didChooseRightArtist: isRightArtist)
        goToNextScreen()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

// MARK: - GameViewModelDelegate

extension GameTableViewController: GameViewModelDelegate {

    func onGeneratedNewQuiz() {
        DispatchQueue.main.async {
            self.navigationController?.view.hideActivityIndicator()
            self.tableView.reloadData()
            self.viewModel.initTimer()
        }
    }

    func onTimerTick(remainingSeconds: Int) {
        let timerLabelText = "secondsRemaining".localized().replacingOccurrences(of: "%1", with: String(remainingSeconds))
        (timerLabelBarButtonItem.customView as? UILabel)?.text = timerLabelText
        toolbarItems = [timerSpacerBarButtonItem, timerLabelBarButtonItem, timerSpacerBarButtonItem]
        navigationController?.setToolbarHidden(false, animated: true)

        if remainingSeconds == 0 {
            updateGameSession(didChooseRightArtist: false)
            goToNextScreen()
        }
    }

}

// MARK: - UI factory

private extension GameTableViewController {

    private func buildSpacerBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    }

    private func buildTimerLabelBarButtonItem() -> UIBarButtonItem {
        let label = UILabel()
        label.textColor = UIColor.text
        return UIBarButtonItem(customView: label)
    }

}
