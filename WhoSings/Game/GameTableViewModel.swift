import Foundation
import os.log

protocol GameViewModelDelegate: class {
    func onGeneratedNewQuiz()
    func onTimerTick(remainingSeconds: Int)
}

class GameTableViewModel {

    private weak var delegate: GameViewModelDelegate?
    private let networkController: NetworkController
    private var songs: [LocalSong]
    private var correctArtist: LocalSong
    private var otherArtists: [LocalSong] { songs.filter { $0.artistName != correctArtist.artistName } }

    var quiz: QuizModel?

    private var remainingSeconds = 10
    private var timer: Timer?

    init(networkController: NetworkController = NetworkController(),
         delegate: GameViewModelDelegate,
         songs: [LocalSong]) {
        self.networkController = networkController
        self.delegate = delegate
        self.songs = songs

        correctArtist = songs.randomElement()!
    }

    deinit {
        Logger.memory.info("GameTableViewModel was deinitialized")
    }

    func generateNewQuiz() {
        networkController.getSongOnAppleMusicCatalog(id: correctArtist.playbackStoreID) { result in
            switch result {
            case .success(let amSongResponse):
                if let isrc = amSongResponse.getISRC() {
                    self.getLyrics(for: isrc)
                }
            case .failure:
                self.tryAgainWithOtherSongs()
            }
        }
    }

    private func getLyrics(for isrc: String) {
        networkController.getSongLyrics(isrc: isrc) { result in
            switch result {
            case .success(let musixmatchLyrics):
                guard let lyricSnippet = musixmatchLyrics.getLyricSnippet(), !lyricSnippet.isEmpty else {
                    self.tryAgainWithOtherSongs()
                    return
                }

                let quiz = QuizModel(artists: self.songs.map { $0.artistName },
                                     lyricLine: lyricSnippet,
                                     lyricCopyright: nil,
                                     correctArtist: self.correctArtist.artistName)
                self.quiz = quiz
                Logger.quiz.info("\(quiz)")
                self.delegate?.onGeneratedNewQuiz()
            case .failure:
                self.tryAgainWithOtherSongs()
            }
        }
    }

    private func tryAgainWithOtherSongs() {
        songs = MediaPlayerController.shared.randomSongsFromUniqueArtists
        correctArtist = self.songs.randomElement()!
        generateNewQuiz()
    }

    // MARK: Timer

    func initTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(onTimerTick),
                                     userInfo: nil,
                                     repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
    }

    @objc private func onTimerTick() {
        delegate?.onTimerTick(remainingSeconds: remainingSeconds)

        if remainingSeconds != 0 {
            remainingSeconds -= 1
        } else {
            timer?.invalidate()
        }
    }

}
