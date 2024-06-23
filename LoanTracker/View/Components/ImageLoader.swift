import SwiftUI

class ImageLoader {
    static func loadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let loadedImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return loadedImage
    }
}
