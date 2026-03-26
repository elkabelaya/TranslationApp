//
//  PHImagePickerRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Photos
import PhotosUI
import Combine

final class PHImagePickerRepository: NSObject, ImagePickerRepositoryProtocol {
    var lastImageInGallery: CurrentValueSubject<Data?, Never> = .init(nil)
    
    private var fetchResult: PHFetchResult<PHAsset>?
    
    var thumbnailSize: CGSize? {
        didSet {
            Task {
                await updateLastPhoto()
            }
        }
    }
    var handle:((TextRecognizable) -> Void)?
    
    override init() {
        super.init()
        PHPhotoLibrary.shared().register(self)
        Task {
            await loadLastPhotoFromGallery()
        }
    }
    
    func isAuthorised() async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .readWrite)//TODO di
        switch status {
        case .authorized, .limited:
            return true
        default:
            return false
        }
    }
    
    func loadLastPhotoFromGallery(_ changes: PHFetchResult<PHAsset>? = nil) async {
        if let changes {
            fetchResult = changes
        } else {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [
                NSSortDescriptor(key: "creationDate", ascending: false)
            ]
            fetchOptions.fetchLimit = 1
            fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        }
        await updateLastPhoto()
        
    }
    
    func updateLastPhoto() async {
        if let asset = fetchResult?.firstObject,
           let thumbnailSize,
           let imageData = try? await PHImageManager.default()
            .requestImageAsData(for: asset,
                          targetSize: thumbnailSize,
                          contentMode: .aspectFit) {
            lastImageInGallery.send(imageData)
        }
    }
}

extension PHImagePickerRepository: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        Task { @MainActor in
            
            guard let fetchResult,
                  let changes = changeInstance.changeDetails(for: fetchResult) else { return }
            await self.loadLastPhotoFromGallery(changes.fetchResultAfterChanges)
        }
    }
}

