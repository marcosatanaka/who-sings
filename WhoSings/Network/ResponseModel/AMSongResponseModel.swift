import Foundation

struct AMSongResponseModel: Codable {
    let data: [AMSong]

    func getISRC() -> String? {
        data.first?.attributes.isrc
    }
}

struct AMSong: Codable {
    let attributes: AMSongAttributes
}

struct AMSongAttributes: Codable {
    let isrc: String
}
