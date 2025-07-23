//
// Copyright © 2025 Sage.
// All Rights Reserved.

import UIKit

protocol ImagesResizeService {
    func resizedToFit(original: UIImage, maxLength: CGFloat) -> UIImage?
}

struct DefaultImagesResizeService: ImagesResizeService {
    func resizedToFit(original: UIImage, maxLength: CGFloat) -> UIImage? {
        let originalSize = original.size
        let maxOriginalDimension = max(originalSize.width, originalSize.height)
        
        // If the image is already within the desired bounds, return it as is
        guard maxOriginalDimension > maxLength else { return original }
        
        let scale = maxLength / maxOriginalDimension
        let newSize = CGSize(width: originalSize.width * scale,
                             height: originalSize.height * scale)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            original.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
