import Foundation
import os.log

class NetworkController {

    private lazy var jsonDecoder = JSONDecoder()

    func getSongOnAppleMusicCatalog(id: String, completion: @escaping (Result<AMSongResponseModel, NetworkError>) -> Void) {
        let storefront = Locale.current.regionCode?.lowercased() ?? "us"
        guard let url = buildURL(host: "api.music.apple.com", path: "/v1/catalog/\(storefront)/songs/\(id)") else {
            completion(.failure(.invalidURL(description: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 15.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization" : Token.appleMusic]

        logRequestBody(request: request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.unknownError(description: error?.localizedDescription)))
                return
            }
            self.logResponse(data: data)
            let decodedData = try? self.jsonDecoder.decode(AMSongResponseModel.self, from: data)
            decodedData == nil ?
                completion(.failure(.decodingError(description: error?.localizedDescription))) :
                completion(.success(decodedData!))
        }.resume()
    }

    func getSongLyrics(isrc: String, completion: @escaping (Result<MusixmatchLyricsResponseModel, NetworkError>) -> Void) {
        let params = ["track_isrc" : isrc, "apikey" : Token.musixmatch]
        guard let url = buildURL(host: "api.musixmatch.com", path: "/ws/1.1/track.snippet.get", queryItems: params) else {
            completion(.failure(.invalidURL(description: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 15.0
        request.httpMethod = "GET"

        logRequestBody(request: request)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.unknownError(description: error?.localizedDescription)))
                return
            }
            self.logResponse(data: data)
            let decodedData = try? self.jsonDecoder.decode(MusixmatchLyricsResponseModel.self, from: data)
            decodedData == nil ?
                completion(.failure(.decodingError(description: error?.localizedDescription))) :
                completion(.success(decodedData!))
        }.resume()
    }

    private func buildURL(host: String, path: String, queryItems: [String: String]? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        return urlComponents.url
    }

}

// MARK: - Log

extension NetworkController {

    private func logRequestBody(request: URLRequest) {
        Logger.network.info("\(request.httpMethod ?? "http request") \(request.url?.absoluteString ?? "")")
    }

    private func logResponse(data: Data) {
//        if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//            Logger.network.info("Response: \(JSONString)")
//        }
    }

}
