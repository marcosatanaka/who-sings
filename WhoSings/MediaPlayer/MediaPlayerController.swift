import Foundation
import MediaPlayer

class MediaPlayerController {

    static let shared = MediaPlayerController()
    private let numberOfTracksForGame = 3

    var randomSongsFromUniqueArtists: [LocalSong] {
        let localSongs = MPMediaQuery.songs().items?.filter { $0.playbackStoreID != "0" }
        var randomArtists = Set<LocalSong?>()
        while randomArtists.count < numberOfTracksForGame {
            randomArtists.insert(LocalSong(from: localSongs?.randomElement()))
        }
        return Array(randomArtists).compactMap { $0 }
    }

    private init() {}

    func hasMinimumAmountOfArtistsToPlay() -> Bool {
        let uniqueArtists = MPMediaQuery.artists().collections?.compactMap { $0.representativeItem?.artist } ?? []
        return uniqueArtists.count >= numberOfTracksForGame
    }

}
