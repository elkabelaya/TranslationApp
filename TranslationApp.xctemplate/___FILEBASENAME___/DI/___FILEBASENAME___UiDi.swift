//___FILEHEADER___

import SwiftUI

extension ServiceLocator {
    func di___VARIABLE_ModuleName___Ui() throws {
        register(___VARIABLE_ModuleName___ViewModelProtocol.self) { r in
            return ___VARIABLE_ModuleName___ViewModel(r.resolve()!)
        }
    }
}
