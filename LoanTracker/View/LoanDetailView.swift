import SwiftUI

struct LoanDetailView: View {
    let loan: Loan
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
                Text("Collateral Value: \(loan.collateral.value)")
                Divider()
                Text("Repayment Schedule:")
                    .font(.headline)
                ForEach(loan.repaymentSchedule.installments, id: \.dueDate) { installment in
                    HStack {
                        Text("Due Date: \(installment.dueDate)")
                        Spacer()
                        Text("Amount Due: \(installment.amountDue)")
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
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

// Sample data for preview
extension Loan {
    static var sampleLoan: Loan {
        return Loan(
            id: "658539b43f5498ccae79105b",
            amount: 5000,
            interestRate: 0.8,
            term: 120,
            purpose: "Business Expansion",
            riskRating: "C",
            borrower: Borrower(
                id: "658539b489fdaab6eae418f3",
                name: "Shelly Valenzuela",
                email: "shellyvalenzuela@orbaxter.com",
                creditScore: 650
            ),
            collateral: Collateral(
                type: "Real Estate",
                value: 100000
            ),
            documents: [
                Document(
                    type: "Income Statement",
                    url: "/loans/documents/income_statement/slip-gaji-karyawan-pertamina.jpeg"
                )
            ],
            repaymentSchedule: RepaymentSchedule(
                installments: [
                    Installment(
                        dueDate: "2023-01-15",
                        amountDue: 500
                    ),
                    Installment(
                        dueDate: "2023-02-15",
                        amountDue: 500
                    )
                ]
            )
        )
    }
}

#Preview {
    LoanDetailView(loan: Loan.sampleLoan)
}
