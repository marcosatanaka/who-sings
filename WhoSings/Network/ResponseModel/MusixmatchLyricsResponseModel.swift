import Foundation

struct MusixmatchLyricsResponseModel: Codable {
    let message: MusixmatchLyricsMessage

    func getLyricSnippet() -> String? {
        return message.body.lyrics.lyricsBody
    }
}

struct MusixmatchLyricsMessage: Codable {
    let body: MusixmatchLyricsBody
}

struct MusixmatchLyricsBody: Codable {
    let lyrics: MusixmatchLyrics

    enum CodingKeys: String, CodingKey {
        case lyrics = "snippet"
    }
}

struct MusixmatchLyrics: Codable {
    let lyricsBody: String

    enum CodingKeys: String, CodingKey {
        case lyricsBody = "snippet_body"
    }
}
