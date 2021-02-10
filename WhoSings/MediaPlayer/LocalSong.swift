import Foundation
import MediaPlayer

struct LocalSong: Hashable, Equatable {
    let artistName: String
    let playbackStoreID: String

    init?(from mpMediaItem: MPMediaItem?) {
        guard let mpMediaItem = mpMediaItem else { return nil }
        self.artistName = mpMediaItem.artist ?? ""
        self.playbackStoreID = mpMediaItem.playbackStoreID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(artistName)
    }

    static func ==(lhs: LocalSong, rhs: LocalSong) -> Bool {
        return lhs.artistName == rhs.artistName
    }
}
