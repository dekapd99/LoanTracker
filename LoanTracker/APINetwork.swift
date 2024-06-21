import Foundation

class APINetwork: ObservableObject {
    @Published var loans = [Loan]()
    
    func fetchLoans() {
        guard let url = URL(string: "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main/api/json/loans.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Loan].self, from: data)
                    DispatchQueue.main.async {
                        self.loans = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
