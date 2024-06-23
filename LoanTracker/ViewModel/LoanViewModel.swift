import Foundation

@MainActor
class LoanViewModel: ObservableObject {
    @Published var loans = [LoanModel]()
    
    private let apiNetwork = APINetwork()
    
    func fetchLoans() {
        Task {
            do {
                let data = try await apiNetwork.fetchData(from: URL.getAllLoans)
                try await decodeData(data)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func decodeData(_ data: Data) async throws {
        do {
            let decodedData = try JSONDecoder().decode([LoanModel].self, from: data)
            loans = decodedData
        } catch {
            throw APINetworkError.decodingError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        switch error {
        case APINetworkError.invalidURL:
            print("Invalid URL")
        case APINetworkError.networkError(let message):
            print("Network error: \(message)")
        case APINetworkError.invalidResponse:
            print("Invalid server response")
        case APINetworkError.decodingError(let error):
            print("Error decoding JSON: \(error)")
        default:
            print("Unexpected error: \(error)")
        }
    }
}
