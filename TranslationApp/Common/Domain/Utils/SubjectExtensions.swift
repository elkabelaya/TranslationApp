//
//  SubjectExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine
import Foundation

extension Subject {
    private func trackNumberOfSubscribers(
            _ notifyChange: @escaping (Int) -> Void
        ) -> Publishers.HandleEvents<Self> {

            var counter = 0
            let nsLock = NSLock()

            func updateCounter(_ change: Int, notify: (Int) -> Void) {
                nsLock.lock()
                counter =  counter + change
                notify(counter)
                nsLock.unlock()
            }

            return self.handleEvents(
                receiveSubscription: { _ in
                    updateCounter(1, notify: notifyChange)
                },
                receiveCompletion: {
                    _ in updateCounter(-1, notify: notifyChange)
                },
                receiveCancel: {
                    updateCounter(-1, notify: notifyChange)
                }
            )
            
        }
    
    func onSubscriptions(onSubscribe: @escaping () -> Void,
                         onUnSubscribe: @escaping () -> Void) -> Publishers.HandleEvents<Self> {
        self
            .trackNumberOfSubscribers { number in
                if number == 0 {
                    onUnSubscribe()
                }
            if number == 1 {
                onSubscribe()
            }
        }
    }
}
