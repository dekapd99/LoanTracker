import SwiftUI

struct CircleComponent: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("ColorLemonDark"))
                .frame(width: 25, height: 25)
            
            Circle()
                .fill(Color("ColorLemonDark"))
                .frame(width: 25, height: 25)
                .offset(x: 12) // Offset the second circle to touch the first one
        }
    }
}

struct CircleComponent_Previews: PreviewProvider {
    static var previews: some View {
        CircleComponent()
            .previewLayout(.sizeThatFits)
    }
}
