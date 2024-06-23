import Foundation

class APINetwork {
    func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APINetworkError.invalidResponse
            }
            
            return data
        } catch {
            throw APINetworkError.networkError(error.localizedDescription)
        }
    }
}
