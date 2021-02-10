import Foundation

enum NetworkError: Error {
    case invalidURL(description: String?)
    case unknownError(description: String?)
    case decodingError(description: String?)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL(let description):
            return description
        case .unknownError(let description):
            return description
        case .decodingError(let description):
            return description
        }
    }
}
