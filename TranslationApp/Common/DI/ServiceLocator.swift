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
    func resolve<Service, Param>(param: Param?)  -> Service?
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
    
    func register<Service, Param>(
        _ for: Service.Type,
        param: Param.Type,
        resolve: @escaping (ResolverProtocol, Param)  -> Service
    )  {
        let key = ObjectIdentifier(Service.self)
        services[key] = LazyParamsService(factory: resolve)
    }
    
    func register<Service>(_ for: Service.Type, _ service: Service)  {
        let key = ObjectIdentifier(Service.self)
        services[key] = service
    }
    
    func resolve<Service>() -> Service? {
        let param: Any? = nil
        return resolve(param: param)
    }
    
    func resolve<Service, Param>(param: Param)  -> Service? {
        let key = ObjectIdentifier(Service.self)
        if let result = services[key] {
            if let resolve = result as? LazyService<Service> {
                return resolve.factory(self)
            } else if let resolve = result as? LazyParamsService<Service, Param> {
                return resolve.factory(self, param)
            }else if let service = result as? Service {
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

fileprivate final class LazyParamsService<Service, Param> {
    var factory: (ResolverProtocol, Param)  -> Service
    
    init(factory: @escaping (ResolverProtocol, Param)  -> Service) {
        self.factory = factory
    }
}

