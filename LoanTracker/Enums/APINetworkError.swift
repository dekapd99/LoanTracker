import Foundation

enum APINetworkError: Error {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case decodingError(Error)
}

enum ImageLoadingError: Error {
    case invalidImageData
}
