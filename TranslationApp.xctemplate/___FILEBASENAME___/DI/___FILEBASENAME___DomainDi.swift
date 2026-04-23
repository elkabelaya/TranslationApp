//___FILEHEADER___

import SwiftUI

extension ServiceLocator {
    func di___VARIABLE_ModuleName___Domain() throws {
        register(___VARIABLE_ModuleName___InteractorProtocol.self) { r in
            return ___VARIABLE_ModuleName___Interactor()
        }
    }
}
