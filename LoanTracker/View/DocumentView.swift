import SwiftUI

struct DocumentView: View {
    let document: Document
    let documentURL: URL
    
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Loan Document Type")
                    .font(.system(size: 16, weight: .light))
                
                Spacer()
                
                Text(document.type)
                    .font(.system(size: 16, weight: .bold))
            }
            .padding(.bottom)
            
            if #available(iOS 15.0, *) {
                AsyncImage(url: documentURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            } else {
                if isLoading {
                    if #available(iOS 14.0, *) {
                        ProgressView()
                            .onAppear {
                                loadImage(from: documentURL)
                            }
                    } else {
                        Text("Loading...")
                            .onAppear {
                                loadImage(from: documentURL)
                            }
                    }
                } else if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("Failed to load image")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    private func loadImage(from url: URL) {
        Task {
            do {
                let loadedImage = try await ImageLoader.loadImage(from: url)
                DispatchQueue.main.async {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}

