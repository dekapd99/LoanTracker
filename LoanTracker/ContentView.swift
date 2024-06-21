import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = APINetwork()
    
    var body: some View {
        NavigationView {
            List(networkManager.loans) { loan in
                VStack(alignment: .leading) {
                    Text("Borrower: \(loan.borrower.name)").font(.headline)
                    Text("Amount: \(loan.amount)")
                    Text("Interest Rate: \(loan.interestRate * 100)%")
                    Text("Term: \(loan.term) months")
                    Text("Purpose: \(loan.purpose)")
                    Text("Risk Rating: \(loan.riskRating)")
                }
            }
            .onAppear {
                networkManager.fetchLoans()
            }
        }
    }
}
#Preview {
    ContentView()
}
