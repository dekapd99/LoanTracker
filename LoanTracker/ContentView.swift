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
    @ObservedObject var viewModel = LoanViewModel()
    @State private var searchQuery = ""
    @State private var selectedSortOption: SortOption = .borrowerName
    @State private var selectedSortOrder: SortOrder = .ascending

    var filteredLoans: [LoanModel] {
        let loans = searchQuery.isEmpty ? viewModel.loans : viewModel.loans.filter {
            $0.borrower.name.lowercased().contains(searchQuery.lowercased())
        }
        
        let sortedLoans: [LoanModel]
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
                TextField("Search by Name", text: $searchQuery)
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Sort by", selection: $selectedSortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 4)
                .padding(.horizontal)

                Picker("Order", selection: $selectedSortOrder) {
                    ForEach(SortOrder.allCases) { order in
                        Text(order.rawValue).tag(order)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical, 8)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredLoans) { loan in
                            NavigationLink(destination: LoanDetailView(loan: loan)) {
                                CardComponent(loan: loan)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.fetchLoans()
                }
            }
            .navigationBarTitle("Loans Tracker List")
        }
    }
}

#Preview {
    ContentView()
}
