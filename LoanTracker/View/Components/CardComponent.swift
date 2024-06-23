import SwiftUI

struct CardComponent: View {
    var loan: LoanModel

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .lastTextBaseline) {
                    Text("$ \(loan.amount, specifier: "%.0f")")
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    Text(loan.purpose)
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Text(loan.borrower.name)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                HStack(content: {
                    Spacer()
                    Group {
                        Text("Risk Rating:")
                            .font(.system(size: 14))
                        Text("\(loan.riskRating)")
                            .font(.system(size: 24, weight: .bold))
                    }
                    Spacer()
                })
                .padding(.bottom, 10)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("\(loan.interestRate, specifier: "%.1f")% Interest Rate")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Spacer()
                    
                    Text("\(loan.term) Days")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(Color("ColorBlueberryDark")) // Use custom color from assets
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 5, y: 5)
            
            CircleComponent()
                .offset(x: -140, y: 10)
            
            Image(systemName: "arrow.right.circle.fill")
                .font(.system(size: 40))
                .background(Color.white)
                .cornerRadius(50)
                .foregroundColor(Color("ColorLemonDark"))
                .offset(x: 160, y: 10) // Adjust position relative to the card content
        }
    }
}

#Preview {
    CardComponent(loan: LoanModel.mockLoanModel)
}
