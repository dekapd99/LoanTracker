import SwiftUI

struct UserInfoComponent: View {
    var loan: LoanModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12, content: {
            VStack(alignment: .center, spacing: 15, content: {
                Text("Amount Due")
                    .font(.system(size: 16, weight: .light))

                Text("$ \(loan.amount, specifier: "%.0f")")
                    .font(.system(size: 32, weight: .semibold))
                
                Rectangle()
                    .fill(.white)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
            })
            
            Text("Basic Info")
                .font(.system(size: 16, weight: .light))
            
            HStack(content: {
                Image("UserExample")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 10)
                    .frame(width: 75, height: 75)  // Adjust the size as needed
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4, content: {
                    Text("\(loan.borrower.name)")
                        .font(.system(size: 20, weight: .semibold))
                    Text("\(loan.purpose)")
                        .font(.system(size: 14))
                })
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
    UserInfoComponent(loan: LoanModel.mockLoanModel)
}
