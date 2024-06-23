import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .lastTextBaseline) {
                    Text("$ 5.000")
                        .font(.system(size: 24, weight: .bold))
                    
                    Spacer()
                    
                    Text("Business Expansion")
                        .font(.system(size: 14, weight: .semibold))
                }
                
                Divider()
                
                HStack {
                    Spacer()
                    Text("Alejandra Mercer")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                HStack(content: {
                    Spacer()
                    Text("Risk Rating: C")
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                })
                .padding(.bottom)
                
                HStack(alignment: .lastTextBaseline) {
                    Text("15% Interest Rate")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Spacer()
                    
                    Text("30 Days")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
            .foregroundColor(.white)
            .frame(width: 300)
            .padding()
            .background(Color("ColorBlueberryDark")) // Use custom color from assets
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 5, y: 5)
            
            CircleComponent()
                .offset(x: -130)
            
            Image(systemName: "arrow.right.circle.fill")
                .font(.system(size: 40))
                .background(Color.white)
                .cornerRadius(50)
                .foregroundColor(Color("ColorLemonDark"))
                .offset(x: 160) // Adjust position relative to the card content
        
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
            .previewLayout(.sizeThatFits)
    }
}
