import Foundation

enum APINetworkError: Error {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case decodingError(Error)
}

class APINetwork: ObservableObject {
    @Published var loans = [Loan]()
    
    func fetchLoans() {
        let url = URL.getAllLoans
        fetchData(from: url)
    }
    
    private func fetchData(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.handleError(.networkError(error.localizedDescription))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.handleError(.invalidResponse)
                return
            }
            
            if let data = data {
                self.decodeData(data)
            } else {
                self.handleError(.invalidResponse)
            }
        }.resume()
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode([Loan].self, from: data)
            DispatchQueue.main.async {
                self.loans = decodedData
            }
        } catch {
            self.handleError(.decodingError(error))
        }
    }
    
    private func handleError(_ error: APINetworkError) {
        DispatchQueue.main.async {
            switch error {
            case .invalidURL:
                print("Invalid URL")
            case .networkError(let message):
                print("Network error: \(message)")
            case .invalidResponse:
                print("Invalid server response")
            case .decodingError(let error):
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
