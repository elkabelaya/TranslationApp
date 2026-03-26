//
//  CameraView.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @State var viewModel: CameraViewModelProtocol
    @State var contentSize: CGSize = .zero

    var body: some View {
        VStack {
            //TODO
            //                LanguagesCardView(
            //                    onLngFromClick: <#T##() -> Void#>,
            //                    onLngToClick: <#T##() -> Void#>,
            //                    onSwapClick: <#T##() -> Void#>)
            Group {
                switch viewModel.state {
                case .video(let session, _):
                    CameraPreview(session: session)
                        
                case .photo(let image):
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
            }
            .readSize { size in
                contentSize = size
            }
            .overlay(
                ForEach(viewModel.observedTexts) { ob in
                    BoundingBox(observation: ob, size: contentSize)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)    
            buttonsView()
        }
        .background(
            Color.appCameraBackground
            .ignoresSafeArea()
        )
        .sheet(isPresented: $viewModel.isPicking) {
            PhotoPicker(onImageSelected: viewModel.onPickImage)
        }
    }
    
    func contentView() -> any View {
        switch viewModel.state {
        case .video(let session, _):
            CameraPreview(session: session)
                .readSize { size in
                    contentSize = size
                }
        case .photo(let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .readSize { size in
                    contentSize = size
                }
        }
    }
    
    func buttonsView() -> some View {
        HStack(spacing: .zero) {
            ThumbnailIcon(
                image: viewModel.previewImage,
                action: viewModel.onThumbnailClick
            )
            CircleIcon(
                .l,
                .appTertiaryBackground,
                .appPrimaryBackground,
                viewModel.onActionClick
            )
            .padding(AppDimens.Paddings.xxxl.rawValue)
            
            Group {
                switch viewModel.state {
                case .video(_, let isTorchOn):
                    IconButton(
                        isTorchOn ? .cameraTorchOff : .cameraTorchOn,
                        .m,
                        .appOnAccentText,
                        viewModel.onTorchClick
                    )
                case .photo:
                    IconButton(
                        .tabCamera,
                        .m,
                        .appOnAccentText,
                        viewModel.onCameraClick
                    )
                }
            }
            
        }
    }
}



#Preview("video") {
    CameraView(viewModel: MockCameraViewModel(state: .video(AVCaptureSession(), true)))
        .background(.black)
}

#Preview("video no torch") {
    CameraView(viewModel: MockCameraViewModel(state: .video(AVCaptureSession(), false)))
        .background(.black)
}

#Preview("photo") {
    CameraView(
        viewModel: MockCameraViewModel(
            state: .photo(
                UIImage(systemName: "pawprint")!
            ),
            previewImage: Image(systemName: "pawprint"),
            observedTexts: TextObservation.mocks
        )
    )
}
