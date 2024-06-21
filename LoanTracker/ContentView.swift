import SwiftUI

enum SortOption: String, CaseIterable, Identifiable {
    case borrowerName = "Borrower Name"
    case riskRating = "Risk Rating"
    case term = "Term"
    
    var id: String { self.rawValue }
}

enum SortOrder: String, CaseIterable, Identifiable {
    case ascending = "Ascending"
    case descending = "Descending"
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    @ObservedObject var networkManager = APINetwork()
    @State private var searchQuery = ""
    @State private var selectedSortOption: SortOption = .borrowerName
    @State private var selectedSortOrder: SortOrder = .ascending

    var filteredLoans: [Loan] {
        let loans = searchQuery.isEmpty ? networkManager.loans : networkManager.loans.filter {
            $0.borrower.name.lowercased().contains(searchQuery.lowercased())
        }
        
        let sortedLoans: [Loan]
        switch selectedSortOption {
        case .borrowerName:
            sortedLoans = loans.sorted { $0.borrower.name.lowercased() < $1.borrower.name.lowercased() }
        case .riskRating:
            sortedLoans = loans.sorted { $0.riskRating < $1.riskRating }
        case .term:
            sortedLoans = loans.sorted { $0.term < $1.term }
        }
        
        return selectedSortOrder == .ascending ? sortedLoans : sortedLoans.reversed()
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by Borrower Name", text: $searchQuery)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Sort by", selection: $selectedSortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Order", selection: $selectedSortOrder) {
                    ForEach(SortOrder.allCases) { order in
                        Text(order.rawValue).tag(order)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List(filteredLoans) { loan in
                    NavigationLink(destination: LoanDetailView(loan: loan)) {
                        VStack(alignment: .leading) {
                            Text("Borrower: \(loan.borrower.name)").font(.headline)
                            Text("Amount: \(loan.amount)")
                            Text("Interest Rate: \(loan.interestRate * 100)%")
                            Text("Term: \(loan.term) months")
                            Text("Purpose: \(loan.purpose)")
                            Text("Risk Rating: \(loan.riskRating)")
                        }
                    }
                }
                .onAppear {
                    networkManager.fetchLoans()
                }
            }
//            .navigationTitle("Loans")
        }
    }
}

#Preview {
    ContentView()
}