//
//  PHImageManagerExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 25.03.2026.
//

import Photos
import UIKit

extension PHImageManager {
    func requestImageAsData(
        for asset: PHAsset,
        targetSize: CGSize,
        contentMode: PHImageContentMode,
        options: PHImageRequestOptions? = nil
    ) async throws -> Data {
        options?.isSynchronous = false
        return try await withCheckedThrowingContinuation { continuation in
            requestImage(
                for: asset,
                targetSize: targetSize,
                contentMode: contentMode,
                options: options
            ) { image, info in
                if let error = info?[PHImageErrorKey] as? Error {
                    continuation.resume(throwing: error)
                    return
                }
                
                if info?[PHImageCancelledKey] as? Bool ?? false {
                    continuation.resume(throwing: CancellationError())
                    return
                }
                
                let isDegraded = info?[PHImageResultIsDegradedKey] as? Bool ?? false
                
                if !isDegraded, let image = image?.pngData() {
                    continuation.resume(returning: image)
                }
            }
        }
    }
}
