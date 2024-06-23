import SwiftUI

struct LoanDetailView: View {
    let loan: LoanModel
    private let baseURL = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Borrower Name: \(loan.borrower.name)")
                    .font(.headline)
                Text("Email: \(loan.borrower.email)")
                Text("Credit Score: \(loan.borrower.creditScore)")
                Divider()
                Text("Collateral Type: \(loan.collateral.type)")
                Text("Collateral Value: \(loan.collateral.value, specifier: "%.0f")")
                Divider()
                Text("Repayment Schedule:")
                    .font(.headline)
                ForEach(loan.repaymentSchedule.installments, id: \.dueDate) { installment in
                    HStack {
                        Text("Due Date: \(installment.dueDate)")
                        Spacer()
                        Text("Amount Due: \(installment.amountDue, specifier: "%.0f")")
                    }
                }
                Divider()
                Text("Loan Documents:")
                    .font(.headline)
                
                if loan.documents.isEmpty {
                    Text("No documents available.")
                } else {
                    ForEach(loan.documents) { document in
                        if let documentURL = URL(string: baseURL + document.url) {
                            DocumentView(document: document, documentURL: documentURL)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct DocumentView: View {
    let document: Document
    let documentURL: URL
    
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(document.type)
                .font(.headline)
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: documentURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
            } else {
                if isLoading {
                    if #available(iOS 14.0, *) {
                        ProgressView()
                            .onAppear {
                                loadImage(from: documentURL)
                            }
                            .frame(height: 200)
                    } else {
                        Text("Loading...")
                            .onAppear {
                                loadImage(from: documentURL)
                            }
                            .frame(height: 200)
                    }
                } else if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } else {
                    Text("Failed to load image")
                        .foregroundColor(.red)
                        .frame(height: 200)
                }
            }
        }
    }
    
    private func loadImage(from url: URL) {
        Task {
            do {
                let loadedImage = try await fetchImage(from: url)
                DispatchQueue.main.async {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    private func fetchImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let loadedImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return loadedImage
    }
}

#Preview {
    LoanDetailView(loan: LoanModel.mockLoanModel)
}
