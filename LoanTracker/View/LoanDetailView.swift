import SwiftUI

struct LoanDetailView: View {
    let loan: LoanModel
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(spacing: 16, content: {
                UserInfoComponent(loan: loan)
                    .padding(.horizontal)
                
                LoanDetailComponent(loan: loan)
                    .padding(.horizontal)
                
                Spacer()
            })
        })
    }
}

#Preview {
    LoanDetailView(loan: LoanModel.mockLoanModel)
}
