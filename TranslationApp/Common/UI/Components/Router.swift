//
//  Router.swift
//  TranslationApp
//
//  Created by elka belaya  on 09.04.2026.
//
import SwiftUI
import Combine

typealias Routable = Hashable & Identifiable & Codable
typealias Tabbable = Hashable & Equatable

protocol RouterProtocol: Observable {
    associatedtype Routing: Routable
    
    var presentingSheet: Binding<Routing?> { get }
    var isPresentingSheet: Binding<Bool> { get }
    var path: Binding<[Routing]> { get }
    
    func navigateTo(_ routing: Routing)
    func presentSheet(_ routing: Routing)
    
    func modal(routing: Routing, rootPresented: Binding<Bool>) -> AnyView
    func navigation(routing: Routing) -> AnyView
}

protocol TabberProtocol: Observable {
    associatedtype Tabbing: Tabbable
    var presentingTab: Tabbing { get set }
    func changeTab(_ tab: Tabbing)
    
    func tab(tabbing: Tabbing) -> AnyView
}


@Observable
class Router<Routing: Routable>: RouterProtocol {
     struct State {
        var presentingSheet: (Routing)? = nil
        var isPresented: Binding<Bool>?
        var path: [Routing] = []
    }
 
    private(set) var state: State
    

    
    init (isPresented: Binding<Bool>? = nil) {
        state = State(isPresented: isPresented)
    }

    func modal(routing: Routing, rootPresented: Binding<Bool>) -> AnyView {
        fatalError("must be implemented in inheriters")
    }
    
    func navigation(routing: Routing) -> AnyView {
        fatalError("must be implemented in inheriters")
    }
    
}

extension Router {
    
    func navigateTo(_ routing: Routing) {
        state.path.append(routing)
    }
    
    func presentSheet(_ routing: Routing) {
        state.presentingSheet = routing
    }
    
    func dismiss() {
        if state.presentingSheet != nil {
            state.presentingSheet = nil
        } else if state.isPresented != nil {
            state.isPresented?.wrappedValue = false
        } else if state.path.count > 0 {
            state.path.removeLast()
        }
    }
    
    func popToRoot() {
        state.presentingSheet = nil
        state.path = []
    }
}

extension Router {
    var path: Binding<[Routing]> {
        binding(keyPath: \.path)
    }
    var presentingSheet: Binding<Routing?> {
        binding(keyPath: \.presentingSheet)
    }

    var isPresentingSheet: Binding<Bool> {
        boolBinding(keyPath: \.presentingSheet)
    }
    
    var isPresented: Binding<Bool> {
        boolBinding(keyPath: \.isPresented)
    }
}

private extension Router {
    func binding<T>(keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
    
    func boolBinding<T>(keyPath: WritableKeyPath<State, T?>) -> Binding<Bool> {
        Binding(
            get: { self.state[keyPath: keyPath] != nil },
            set: {
                if !$0 {
                    self.state[keyPath: keyPath] = nil
                }
            }
        )
    }
}

fileprivate struct RoutingModifier<Routing: Routable, Router: RouterProtocol>: ViewModifier where Routing == Router.Routing{
    @State var router: Router
    
    func body(content: Content) -> some View {
        NavigationStack(path: router.path) {
            content
        }
    }
}

extension View {
    func navigationStack<Routing: Routable, Router: RouterProtocol>(_ router: Router) -> some View where Routing == Router.Routing {
        self.modifier(RoutingModifier(router: router))
    }
    
    func router<Routing: Routable, Router: RouterProtocol>(_ router: Router) -> some View where Routing == Router.Routing {
        self
            .navigationDestination(for: Routing.self) { route in
                router.navigation(routing: route)
            }
            .sheet(item: router.presentingSheet) { route in
                router.modal(routing: route, rootPresented: router.isPresentingSheet)
            }
    }
}
