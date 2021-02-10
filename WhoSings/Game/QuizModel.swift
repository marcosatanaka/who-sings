import Foundation

struct QuizModel {
    let artists: [String]
    let lyricLine: String?
    let lyricCopyright: String?
    let correctArtist: String
}

extension QuizModel: CustomStringConvertible {
    var description: String {
        return "\(artists) || \(lyricLine ?? "") ==> \(correctArtist)"
    }
}
