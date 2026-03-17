//
//  ListContextObserver.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftData
import Combine
import Foundation

open class ListContextObserverBase<ListItem> {
    let context: ModelContext
    private let _itemsPublisher: CurrentValueSubject<[ListItem], Never> = .init([])
    private var contextSubscription: AnyCancellable?
    
    lazy var itemsPublisher: Publisher<[ListItem], Never> = _itemsPublisher.onSubscriptions(
        onSubscribe: { [weak self] in
            self?.onSubscribe()
        },
        onUnSubscribe: {
            [weak self] in
            self?.onUnsubscribe()
        }
    )
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func updateListItems() async throws -> [ListItem]{
        throw("must be overridden")
    }
    
    private func updateAndSend() {
        Task {
            let items = try await updateListItems()
            _itemsPublisher.send( items)
        }
        
    }
    private func onSubscribe(){
        updateAndSend()
        
        contextSubscription = NotificationCenter.default
            .publisher(for: ModelContext.didSave)
            .sink(receiveValue: { [weak self] notification in
                if let updatedContext = notification.object as? ModelContext,
                    updatedContext == self?.context {
                    self?.updateAndSend()
                }
            })
    }
    
    private func onUnsubscribe(){
        contextSubscription?.cancel()
    }
    
}
