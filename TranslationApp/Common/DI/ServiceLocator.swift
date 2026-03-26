//
//  ServiceLocator.swift
//  TranslationApp
//
//  Created by elka belaya  on 18.03.2026.
//

protocol RegistratorProtocol: Sendable {
    func register<Service>(_ for: Service.Type, resolve: @escaping (ResolverProtocol) -> Service)
    func register<Service>(_ for: Service.Type, _ service: Service)
}

protocol ResolverProtocol: Sendable {
    func resolve<Service>() -> Service?
}

protocol ServiceLocatorProtocol: RegistratorProtocol, ResolverProtocol {}

final class ServiceLocator: ServiceLocatorProtocol {
    private var services: [ObjectIdentifier: Any] = [:]
    
    func register<Service>(
        _ for: Service.Type,
        resolve: @escaping (ResolverProtocol)  -> Service
    )  {
        let key = ObjectIdentifier(Service.self)
        services[key] = LazyService(factory: resolve)
    }
    
    func register<Service>(_ for: Service.Type, _ service: Service)  {
        let key = ObjectIdentifier(Service.self)
        services[key] = service
    }
    
    func resolve<Service>()  -> Service? {
        let key = ObjectIdentifier(Service.self)
        if let result = services[key] {
            if let resolve = result as? LazyService<Service> {
                return resolve.factory(self)
            } else if let service = result as? Service {
                return service
            }
        }
        
        return nil
    }
}

fileprivate final class LazyService<Service> {
    var factory: (ResolverProtocol)  -> Service
    
    init(factory: @escaping (ResolverProtocol)  -> Service) {
        self.factory = factory
    }
}

