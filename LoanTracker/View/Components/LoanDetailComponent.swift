import SwiftUI

struct LoanDetailComponent: View {
    var loan: LoanModel
    private let baseURL = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main"
    
    var body: some View {
        VStack(spacing: 12, content: {
            VStack(alignment: .center, spacing: 10, content: {
                HStack(content: {
                    Text("Email")
                        .font(.system(size: 14, weight: .light))
                    
                    Spacer()
                    
                    Text("Credit Score")
                        .font(.system(size: 14, weight: .light))
                })
                
                HStack(content: {
                    Text("\(loan.borrower.email)")
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                    
                    Text("650")
                        .font(.system(size: 16, weight: .bold))
                })
                
                Rectangle()
                    .fill(.white)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                
                HStack(content: {
                    Text("Collateral Type")
                        .font(.system(size: 14, weight: .light))
                    
                    Spacer()
                    
                    Text("Value")
                        .font(.system(size: 14, weight: .light))
                })
                
                HStack(content: {
                    Text("\(loan.collateral.type)")
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                    
                    Text("$ \(loan.collateral.value, specifier: "%.0f")")
                        .font(.system(size: 16, weight: .bold))
                })
                
                Rectangle()
                    .fill(.white)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                
                HStack(content: {
                    Text("Due Date")
                        .font(.system(size: 14, weight: .light))
                    
                    Spacer()
                    
                    Text("Amount Due")
                        .font(.system(size: 14, weight: .light))
                })
                
                ForEach(loan.repaymentSchedule.installments, id: \.dueDate) { installment in
                    HStack(content: {
                        Text("\(installment.dueDate)")
                            .font(.system(size: 16, weight: .bold))
                        
                        Spacer()
                        
                        Text("\(installment.amountDue, specifier: "%.0f")")
                            .font(.system(size: 16, weight: .bold))
                    })
                }
                
                Rectangle()
                    .fill(.white)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                
                if loan.documents.isEmpty {
                    Text("No documents available.")
                } else {
                    ForEach(loan.documents) { document in
                        if let documentURL = URL(string: baseURL + document.url) {
                            DocumentView(document: document, documentURL: documentURL)
                        }
                    }
                }
            })
        })
        .foregroundColor(.white)
        .padding()
        .background(Color("ColorBlueberryDark")) // Use custom color from assets
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}

#Preview {
    LoanDetailComponent(loan: LoanModel.mockLoanModel)
}
